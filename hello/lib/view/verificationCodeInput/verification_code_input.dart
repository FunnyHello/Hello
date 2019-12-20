import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodeInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerificationCodeInputState();
  }
}

class VerificationCodeInputState extends State<VerificationCodeInput> {
  var _oneController = TextEditingController();
  var _twoController = TextEditingController();
  var _threeController = TextEditingController();
  var _fourController = TextEditingController();

  FocusNode _noeFocus = FocusNode();
  FocusNode _twoFocus = FocusNode();
  FocusNode _threeFocus = FocusNode();
  FocusNode _fourFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //默认第一个获取焦点
    FocusScope.of(context).requestFocus(_noeFocus);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initView();
  }

  Widget initView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment(0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 64,
            width: 56,
            alignment: Alignment(0, 0),
            child: TextField(
              style: TextStyle(
                fontSize: 28.0,
                color: const Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
              focusNode: _noeFocus,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1)
              ],
              controller: _oneController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 64,
            width: 56,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                color: const Color(0xFF333333),
              ),
              focusNode: _twoFocus,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1)
              ],
              controller: _twoController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 64,
            width: 56,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                color: const Color(0xFF333333),
              ),
              focusNode: _threeFocus,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1)
              ],
              controller: _threeController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 64,
            width: 56,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                color: const Color(0xFF333333),
              ),
              focusNode: _fourFocus,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1)
              ],
              controller: _fourController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
