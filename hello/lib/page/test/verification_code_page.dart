import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/view/inputCode/verification_code_input.dart';

class VerificationCodePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerificationCodePageState();
  }
}

class VerificationCodePageState extends BaseState<VerificationCodePage> {
  var underLineBorder;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

     ///边框
     underLineBorder = CustomRectInputBorder(
        letterSpace: 30.0,
        textSize: 50.0,
        textLength: 4,
        borderSide:
            BorderSide(color: Colors.blue.withOpacity(0.6), width: 2.0));
    return Scaffold(
      appBar: AppBar(
        title: Text('测试验证码输入'),
      ),
      body: initView(),
    );
  }

  initView() {
    return Container(
      child: VerificationCodeInput(
        textSize: 50.0,
        letterSpace: 30.0,
        inputBorder: underLineBorder,
      ),
    );
  }
}
