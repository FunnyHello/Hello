package com.example.hello.ui.activity

import android.os.Bundle
import com.example.hello.R
import com.example.hello.base.activity.BaseActivity

/**
 * Created by hzx_s on 2019/12/17.
 * Describe:
 */
class TestActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_test)
    }
}