import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/utils/type_utils.dart';

class RegisterPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BaseState<RegisterPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //销毁文本控制器
    _userPassController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("注册", style: new TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: initView(),
    );
  }

  Widget initView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
          child: new TextField(
            style: hintTips,
            controller: _userNameController,
            decoration: new InputDecoration(hintText: "请输入用户名"),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
          child: new TextField(
            style: hintTips,
            controller: _userPassController,
            decoration: new InputDecoration(hintText: "请输入用户密码"),
            obscureText: true,
          ),
        ),
        new Container(
          width: 360.0,
          margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          padding: new EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
              leftRightPadding, topBottomPadding),
          child: new Card(
            color: Colors.green,
            elevation: 6.0,
            child: new FlatButton(
                onPressed: () {
                  ToastUtil.showMsg("注册了");
                  register();
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text(
                    '马上注册',
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )),
          ),
        )
      ],
    );
  }

  register() {
    if (isEmpty(_userNameController.text)) {
      ToastUtil.showMsg("用户名不能为空");
      return;
    }
    if (isEmpty(_userPassController.text)) {
      ToastUtil.showMsg("密码不能为空");
      return;
    }

    var param = {
      "userName": _userNameController.text,
      "password": _userPassController.text
    };
    NetConnection.getInstance().post(
      TEST_REGISTER,
      (data) {
        setState(() {
          ToastUtil.showMsg("请求成功");
          //销毁当前页面
          Navigator.pop(context);
        });
      },
      errorCallBack: (Function errorCallBack, String error) {},
      param: param,
    );
  }
}
