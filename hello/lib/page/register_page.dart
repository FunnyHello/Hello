import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/toast_util.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = TextEditingController();
  var _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册", style: TextStyle(color: Colors.white)),
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
        Padding(
          padding: EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
          child: TextField(
            style: hintTips,
            controller: _userNameController,
            decoration: InputDecoration(hintText: "请输入用户名"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
          child: TextField(
            style: hintTips,
            controller: _userPassController,
            decoration: InputDecoration(hintText: "请输入用户密码"),
            obscureText: true,
          ),
        ),
        new Container(
          width: 360.0,
          margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          padding: EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
              leftRightPadding, topBottomPadding),
          child: Card(
            color: Colors.green,
            elevation: 6.0,
            child: FlatButton(
                onPressed: () {
                  ToastUtil.showMsg("注册了");
                  register();
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '马上注册',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )),
          ),
        )
      ],
    );
  }

  register() {
    if (_userNameController.text.isEmpty) {
      ToastUtil.showMsg("用户名不能为空");
      return;
    }
    if (_userPassController.text.isEmpty) {
      ToastUtil.showMsg("密码不能为空");
      return;
    }
    String string = json.encode({
      "userName": _userNameController.text,
      "password": _userPassController.text
    });
    NetConnection.getInstance().post(
      Constant.TEST_REGISTER,
      (data) {
        //UserDetail userDetail = UserDetail.fromJson(data);
        //var name = userDetail.username;
        setState(() {
          ToastUtil.showMsg("请求成功");
          //销毁当前页面
          Navigator.pop(context);
        });
      },
      errorCallBack: (Function errorCallBack, String error) {},
      formData: FormData.from({'data': string}),
    );
  }
}
