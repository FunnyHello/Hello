package com.example.hello.utils

import android.app.Activity
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

/**
 * Created by hzx_s on 2019/12/23.
 * Describe:
 */
class NativeMethodPlugin(registrar: Registrar, activity: Activity) : MethodChannel.MethodCallHandler {
    companion object {
        val CHANNEL = "com.example.hello"
    }

    private val activity: Activity = activity
    private val result: MethodChannel.Result? = null

    init {
        val channel = MethodChannel(registrar.messenger(), CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(p0: MethodCall, p1: MethodChannel.Result) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        result = p1
        if (p0.method == "Method") {
//            val test: String = p0.argument("test")
//            Toast.makeText(activity, "" + test, Toast.LENGTH_SHORT).show()
//            result.success("接收成功")
        }
    }

}