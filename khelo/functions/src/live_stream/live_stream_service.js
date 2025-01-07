"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.LiveStreamService = void 0;
const {google} = require("googleapis");

const resolutionFrameRates = {
  "144p": "24fps",
  "240p": "24fps",
  "360p": "30fps",
  "480p": "30fps",
  "720p": "60fps",
  "1080p": "60fps",
};

class LiveStreamService {
  constructor(liveStreamRepository, userRepository, authService) {
    this.liveStreamRepository = liveStreamRepository;
    this.userRepository = userRepository;
    this.authService = authService;
  }

  async createYouTubeStream(req, res) {
    try {
      const userId = req.headers["auth-uid"];
      if (!userId) {
        console.error("AuthService: unauthorized request");
        return res.status(400).send("unauthorized");
      }
      const data = req.body;
      let refreshToken;
      if (data.option === "userYTChannel") {
        const userDoc = await this.userRepository.getUser(userId);
        if (!userDoc) {
          console.error("User not found");
          return res.status(404).send("User not found");
        }
        refreshToken = userDoc.google_refresh_token;
      } else {
        refreshToken = process.env.KHELO_GOOGLE_REFRESH_TOKEN;
      }

      if (!refreshToken) {
        console.error("No refresh token available for this user.");
        return res.status(400).send("No refresh token available.");
      }

      const oauth2Client = new google.auth.OAuth2(
        process.env.WEB_CLIENT_ID,
        process.env.WEB_CLIENT_SECRET,
        process.env.REDIRECT_URL,
      );

      oauth2Client.setCredentials({
        refresh_token: refreshToken,
      });

      const {credentials} = await oauth2Client.refreshAccessToken();
      oauth2Client.setCredentials(credentials);
      const youtube = google.youtube({
        version: "v3",
        auth: oauth2Client,
      });

      const broadcast = {
        snippet: {
          title: data.name || "Live Cricket Match",
          description: "Live cricket match",
          scheduledStartTime: new Date(data.scheduledStartTime).toISOString(),
        },
        status: {
          privacyStatus: "public",
          selfDeclaredMadeForKids: false,
        },
        contentDetails: {
          enableContentEncryption: false, // TODO: Set to true if you need encryption
          enableDvr: true,
          enableMonitorStream: true,
          recordFromStart: true,
          enableAutoStart: true,
        },
      };

      const channelId = data.channelId || process.env.KHELO_YOUTUBE_CHANNEL_ID;

      const broadcastResponse = await youtube.liveBroadcasts.insert({
        part: "snippet,status,contentDetails",
        resource: broadcast,
        params: {
          channelId: channelId,
        },
      });

      const stream = {
        snippet: {
          title: "Cricket Live Stream",
        },
        cdn: {
          frameRate: resolutionFrameRates[data.resolution || "1080p"],
          ingestionType: "rtmp",
          resolution: data.resolution || "1080p",
        },
      };

      const streamResponse = await youtube.liveStreams.insert({
        part: "snippet,cdn",
        resource: stream,
      });

      await youtube.liveBroadcasts.bind({
        id: broadcastResponse.data.id,
        part: "id,contentDetails",
        streamId: streamResponse.data.id,
      });
      const streamKey = streamResponse.data.cdn.ingestionInfo.streamKey;
      const streamInfo = await this.liveStreamRepository.addStream({
        rtmp_url: streamResponse.data.cdn.ingestionInfo.ingestionAddress + "/" + streamResponse.data.cdn.ingestionInfo.streamName,
        stream_id: streamResponse.data.id,
        broadcast_id: broadcastResponse.data.id,
        title: broadcastResponse.data.snippet.title,
        match_id: data.matchId,
        status: "pending",
      });
      return res.status(200).send(streamInfo);
    } catch (error) {
      console.error(error);
      return res.status(400).send(error);
    }
  }

  async getYouTubeChannel(req, res) {
    try {
      const userId = req.headers["auth-uid"];
      if (!userId) {
        console.error("AuthService: unauthorized request");
        return res.status(400).send("unauthorized");
      }

      const userDoc = await this.userRepository.getUser(userId);
      if (!userDoc) {
        console.error("User not found");
        return res.status(404).send("User not found");
      }
      const refreshToken = userDoc.google_refresh_token;
      console.log("Refresh token:", refreshToken);

      if (!refreshToken) {
        console.error("No refresh token available for this user.");
        return res.status(400).send("No refresh token available.");
      }

      const oauth2Client = new google.auth.OAuth2(
        process.env.WEB_CLIENT_ID,
        process.env.WEB_CLIENT_SECRET,
        process.env.REDIRECT_URL,
      );

      oauth2Client.setCredentials({
        refresh_token: refreshToken,
      });

      // Try to refresh the access token
      const {credentials} = await oauth2Client.refreshAccessToken();
      oauth2Client.setCredentials(credentials);

      const youtube = google.youtube({
        version: "v3",
        auth: oauth2Client,
      });

      // Get the user's YouTube channel details using the authenticated OAuth2 client
      const response = await youtube.channels.list({
        part: "snippet, status", // You can modify the parts you need
        mine: true, // This gets the authenticated user's channel
      });

      return res.status(200).send(response.data);
    } catch (error) {
      return res.status(400).send(error);
    }
  }
}
exports.LiveStreamService = LiveStreamService;
