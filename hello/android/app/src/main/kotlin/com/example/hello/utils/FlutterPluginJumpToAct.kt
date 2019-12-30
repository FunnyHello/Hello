package com.example.hello.utils

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import com.example.hello.ui.activity.TestActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterPluginJumpToAct(activity: Activity) : MethodCallHandler {
    val activity: Activity = activity

    companion object {
        val CHANNEL = "com.example.hello"
        var channel: MethodChannel? = null
        fun registerWith(registrar: Registrar) {
            channel = MethodChannel(registrar.messenger(), CHANNEL)
            val instance = FlutterPluginJumpToAct(registrar.activity())
            //setMethodCallHandler在此通道上接收方法调用的回调
            channel!!.setMethodCallHandler(instance)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务
        //接收来自flutter的指令oneAct
        if (call.method == "startActivity") { //跳转到指定Activity
            val text: String? = call.argument("flutter")
            //这里滑稽
            Toast.makeText(activity, "" + text, Toast.LENGTH_SHORT).show()
            //注意：activity必须在清单文件里面引用主题，否则activity没有主题参数（直接报错）
            val intent = Intent(activity, TestActivity::class.java)
            activity.startActivity(intent)
            //返回给flutter的参数
            result.success("success")
        } else {
            result.notImplemented()
        }
    }


}