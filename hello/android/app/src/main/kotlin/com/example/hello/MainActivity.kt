package com.example.hello

import androidx.annotation.NonNull;
import com.example.hello.utils.NativeMethodPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    var nativeMethodPlugin: NativeMethodPlugin? = null
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

//        nativeMethodPlugin = NativeMethodPlugin(registrarFor(NativeMethodPlugin.CHANNEL), this)
    }
}
