package com.ethiopia.tourist.tourist_assistive_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.ethiopia.tourist.tourist_assistive_app.VoiceServicePlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(VoiceServicePlugin())
    }
}


