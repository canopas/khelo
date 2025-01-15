"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.LiveStreamRepository = void 0;

class LiveStreamRepository {
  constructor(db) {
    this.db = db;
  }
  liveStreamRef() {
    return this.db.collection("live_streams");
  }
  async addStream(streamInfo) {
    try {
      const userRef = this.liveStreamRef().doc();
      const stream = {
        id: userRef.id,
        ...streamInfo,
      };
      await userRef.set(stream);
      return stream;
    } catch (e) {
      console.error("LiveStreamRepository: Error in adding stream:", e);
      return null;
    }
  }
}
exports.LiveStreamRepository=LiveStreamRepository;
