package com.example.hello.utils

import android.app.Activity
import androidx.lifecycle.Observer
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.reactivex.Observable
import io.reactivex.disposables.Disposable
import java.util.concurrent.TimeUnit


class FlutterPluginCounter private constructor(val activity: Activity) : EventChannel.StreamHandler {
    companion object {
        val CHANNEL = "com.example.hello"
        var channel: EventChannel? = null
        fun registerWith(registrar: Registrar) {
            channel = EventChannel(registrar.messenger(), CHANNEL)
            val instance = FlutterPluginCounter(registrar.activity())
            channel!!.setStreamHandler(instance)
        }
    }

    override fun onListen(o: Any, eventSink: EventSink) {
//      
    }

    override fun onCancel(o: Any) {
    }

}