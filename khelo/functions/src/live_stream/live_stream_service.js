"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.LiveStreamService = void 0;
const {google} = require("googleapis");

class LiveStreamService {
  constructor(liveStreamRepository) {
    this.liveStreamRepository = liveStreamRepository;
  }

  async createYouTubeStream(req, res) {
    try {
      const userId = req.headers["auth-uid"];
      if (!userId) {
        console.error("LiveStreamService: unauthorized request");
        return res.status(400).send("unauthorized");
      }
      const data = req.body;

      const auth = new google.auth.GoogleAuth({
        keyFile: "./google-application-credentials.json",
        scopes: ["https://www.googleapis.com/auth/youtube.force-ssl"],
      });
      const client = await auth.getClient();
      client.setCredentials({id_token: req.get("Authorization").split("Bearer ")[1]});

      const youtube = google.youtube({version: "v3", auth: client});

      const broadcast = {
        snippet: {
          title: data.title || "My Live Stream", // Use title from client or default
          description: data.description || "Live stream from my app",
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

      const broadcastResponse = await youtube.liveBroadcasts.insert({
        part: "snippet,status,contentDetails",
        resource: broadcast,
      });

      const stream = {
        snippet: {
          title: "My Stream",
        },
        cdn: {
          format: "1080p",
          ingestionType: "rtmp",
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

      const streamInfo = await this.liveStreamRepository.addStream({
        rtmp_url: streamResponse.data.cdn.ingestionInfo.ingestionAddress + "/" + streamResponse.data.cdn.ingestionInfo.streamName,
        stream_id: streamResponse.data.id,
        broadcast_id: broadcastResponse.data.id,
        title: broadcastResponse.data.snippet.title,
        match_id: data.match_id,
        status: "pending",
      });
      return res.status(200).send(streamInfo);
    } catch (error) {
      return res.status(400).send(error);
    }
  }
}
exports.LiveStreamService = LiveStreamService;
