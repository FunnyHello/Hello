import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/view/codeInput/custom_code_field.dart';
import 'package:hello/view/codeInput/key_event.dart';
import 'package:hello/view/codeInput/my_key_board.dart';

class PasswordInputPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PasswordInputPageState();
  }
}

class PasswordInputPageState extends BaseState<PasswordInputPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallback;
  String pwdData = '';

  @override
  void initState() {
    _showBottomSheetCallback = _showBottomKeyboard;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('测试密码输入'),
      ),
      body: initView(),
    );
  }

  initView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child:  Container(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: CustomCodeField(pwdData),
            ),
            onTap: (){
              _showBottomSheetCallback();
            },
          ),

        ],
      ),
    );
  }

  void _showBottomKeyboard() {
    setState(() {
      // 禁用按钮
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
      return  MyKeyboard(_onKeyDown);
    })
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          // 重新启用按钮
          _showBottomSheetCallback = _showBottomKeyboard;
        });
      }
    });
  }

  void _onKeyDown(KeyEvent data){
    if (data.isDelete()) {
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      if (pwdData.length != 6) {
//        Fluttertoast.showToast(msg: "密码不足6位，请重试", gravity: ToastGravity.CENTER);
        return;
      }
      onAffirmButton();
    } else {
      if (pwdData.length < 6) {
        pwdData += data.key;
      }
      setState(() {});
    }
  }

  /// 密码键盘 确认按钮 事件
  void onAffirmButton() {

  }
}
