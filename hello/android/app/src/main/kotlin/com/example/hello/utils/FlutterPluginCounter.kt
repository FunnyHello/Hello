package com.example.hello.utils

import android.app.Activity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry
import io.reactivex.Observable
import io.reactivex.Observer
import io.reactivex.disposables.Disposable
import java.util.concurrent.TimeUnit


class FlutterPluginCounter private constructor(val activity: Activity) : EventChannel.StreamHandler {
    companion object {
        val CHANNEL = "com.example.hello"
        var channel: EventChannel? = null
        fun registerWith(registrar: PluginRegistry.Registrar) {
            channel = EventChannel(registrar.messenger(), CHANNEL)
            val instance = FlutterPluginCounter(registrar.activity())
            channel!!.setStreamHandler(instance)
        }
    }

    override fun onListen(o: Any, eventSink: EventChannel.EventSink) {
        Observable.interval(1000, TimeUnit.MILLISECONDS).subscribe(object : Observer<Long?> {
            override fun onSubscribe(d: Disposable) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun onNext(t: Long) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
                eventSink.success(t.toInt())
            }

            override fun onError(e: Throwable) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
                eventSink.error("计时器异常", "异常", e.message)
            }

            override fun onComplete() {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }
        })
    }

    override fun onCancel(o: Any) {
    }

}