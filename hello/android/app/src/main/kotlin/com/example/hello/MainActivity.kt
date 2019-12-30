package com.example.hello

import androidx.annotation.NonNull
import com.example.hello.utils.FlutterPluginCounter
import com.example.hello.utils.FlutterPluginJumpToAct
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        FlutterPluginJumpToAct.registerWith(ShimPluginRegistry(flutterEngine).registrarFor(FlutterPluginJumpToAct.CHANNEL))
        FlutterPluginCounter.registerWith(ShimPluginRegistry(flutterEngine).registrarFor(FlutterPluginCounter.CHANNEL))
    }


}
