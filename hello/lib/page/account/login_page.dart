import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/page/account/register_page.dart';
import 'package:hello/utils/toast_util.dart';

class LoginPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseState<LoginPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  //控制TextField焦点
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //监听文本控制器
    _userPassController.addListener(() {});

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        ///TextField失去焦点
      }
    });
  }

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
      //防止键盘挤压界面（但是键盘会挡住输入框）
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("登录", style: new TextStyle(color: Colors.white)),
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(85.0, 50.0, 85.0, 0.0),
          child: Text(
            "We sent you a code to verify your phone number",
            //文字居中
            textAlign: TextAlign.center,
            style: TextStyle(
              //字体：粗体
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: const Color(0xFF333333),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              leftRightPadding, 20.0, leftRightPadding, topBottomPadding),
          child: TextField(
            //自动获取焦点
            autofocus: true,
            focusNode: _focusNode,
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
            decoration: InputDecoration(
              hintText: "请输入用户密码",
              //去掉下划线
//              border: InputBorder.none,
            ),
//            keyboardType: TextInputType.number,//键盘类型，数字键盘
//            inputFormatters: <TextInputFormatter>[
//              WhitelistingTextInputFormatter.digitsOnly, //只输入数字
//              LengthLimitingTextInputFormatter(11) //限制长度
//            ],
            //限制输入数字，字母，汉字
//            inputFormatters: <TextInputFormatter>[
//              WhitelistingTextInputFormatter(RegExp(
//                  "[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
//              LengthLimitingTextInputFormatter(3)
//            ],
            //文本居中
//            textAlign: TextAlign.center,
            obscureText: true,
          ),
        ),
        Container(
          width: 360.0,
          margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          padding: EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
              leftRightPadding, topBottomPadding),
          child: Card(
            color: Colors.green,
            elevation: 6.0,
            child: FlatButton(
                onPressed: () {
                  ToastUtil.showMsg(_userNameController.text + "登陆了");
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )),
          ),
        ),
        Container(
          width: 360.0,
          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          padding: EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
              leftRightPadding, topBottomPadding),
          child: Card(
            color: Colors.green,
            elevation: 6.0,
            child: FlatButton(
                onPressed: () {
                  ToastUtil.showMsg("点击注册");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return RegisterPage();
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '注册',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )),
          ),
        ),
        Container(
          height: 40,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: const Color(0xFF101010),
            ),
            text: '登录即表明您同意我们的 ',
          ),
          TextSpan(
              text: '服务条款',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showToast("服务条款");
                }),
          TextSpan(
            text: ' 和 ',
            style: TextStyle(
              fontSize: 14.0,
              color: const Color(0xFF101010),
            ),
          ),
          TextSpan(
              text: '隐私策略',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showToast("隐私策略");
                })
        ])),
      ],
    );
  }
}
