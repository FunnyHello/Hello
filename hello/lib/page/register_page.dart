import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/text_utils.dart';
import 'package:hello/utils/toast_util.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("注册", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
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
    if(TextUtils.isEmpty(_userNameController.text)){
      ToastUtil.showMsg("用户名不能为空");
      return;
    }
    if(TextUtils.isEmpty(_userPassController.text)){
      ToastUtil.showMsg("密码不能为空");
      return;
    }
    String string = json.encode({"userName": _userNameController.text, "password":_userPassController.text});
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
      errorCallBack: (Function errorCallBack, String error) {
      },
      formData: FormData.from({'data':string}),
    );
  }
}
