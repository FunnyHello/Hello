import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/view/inputCode/cell_input.dart';

class VerificationCodePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerificationCodePageState();
  }
}

class VerificationCodePageState extends BaseState<VerificationCodePage> {
  String _groupValue = "密码";
  InputType _inputType = InputType.password;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('测试验证码输入'),
      ),
      body: initView(),
    );
  }

  initView() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CellInput(
              key: UniqueKey(),
              autofocus: true,
              inputType: _inputType,
              solidColor: Color(0xFFF5F6FB),
              borderRadius: BorderRadius.circular(4),
              inputCompleteCallback: (v) {
                print(v);
              }),
          RadioListTile<String>(
              value: '密码',
              title: Text('密码'),
              groupValue: _groupValue,
              onChanged: (v) {
                setState(() {
                  _inputType = InputType.password;
                  _groupValue = v;
                });
              }),
          RadioListTile<String>(
              value: '数字',
              groupValue: _groupValue,
              title: Text('数字'),
              onChanged: (v) {
                setState(() {
                  _inputType = InputType.number;
                  _groupValue = v;
                });
              }),
          RadioListTile<String>(
              value: '文本',
              groupValue: _groupValue,
              title: Text('文本'),
              onChanged: (v) {
                setState(() {
                  _inputType = InputType.text;
                  _groupValue = v;
                });
              }),
        ],
      ),
    );
  }
}
