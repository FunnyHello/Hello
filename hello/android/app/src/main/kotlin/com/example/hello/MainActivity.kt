package com.example.hello

import androidx.annotation.NonNull
import com.example.hello.utils.FlutterPluginJumpToAct
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

//        FlutterPluginJumpToAct.registerWith(flutterEngine.registrarFor(FlutterPluginJumpToAct.CHANNEL))
//        FlutterPluginJumpToAct.registerWith(this.registrarFor(FlutterPluginJumpToAct.CHANNEL))
    }


}
