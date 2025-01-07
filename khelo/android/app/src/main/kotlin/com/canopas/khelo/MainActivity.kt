package com.canopas.khelo

import io.flutter.embedding.android.FlutterActivity
//import io.flutter.plugin.common.MethodChannel
//import android.os.Bundle
//import androidx.annotation.NonNull
//import com.nodeandroid.node_media_client.NodeMediaClient
//import com.nodeandroid.node_media_client.NodePlayer

class MainActivity: FlutterActivity() {
//    private val CHANNEL = "com.khelo.liveStream"
//    private lateinit var nodePlayer: NodePlayer
//
//    override fun configureFlutterEngine() {
//        super.configureFlutterEngine()
//        MethodChannel(flutterEngine?.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "startStreaming") {
//                val rtmpUrl = call.argument<String>("rtmpUrl")
//                if (rtmpUrl != null) {
//                    startStreaming(rtmpUrl)
//                    result.success("Streaming started")
//                } else {
//                    result.error("INVALID_URL", "RTMP URL is missing", null)
//                }
//            } else if (call.method == "stopStreaming") {
//                stopStreaming()
//                result.success("Streaming stopped")
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun startStreaming(rtmpUrl: String) {
//        // Initialize the NodePlayer and start streaming
//        nodePlayer = NodePlayer(applicationContext)
//        nodePlayer.setUrl(rtmpUrl)
//        nodePlayer.setInputStreamType(NodePlayer.INPUT_STREAM_TYPE_CAMERA) // Stream from camera
//        nodePlayer.prepare()
//        nodePlayer.start()
//    }
//
//    private fun stopStreaming() {
//        if (::nodePlayer.isInitialized) {
//            nodePlayer.stop()
//        }
//    }
}
