import 'package:flutter/material.dart';

class CustomKeyBoardButton extends StatefulWidget {
  String text;
  CustomKeyBoardButton({Key key, this.text, this.callback}) : super(key: key);
  final callback;
  @override
  State<StatefulWidget> createState() {
    return CustomKeyBoardButtonState();
  }
}
class CustomKeyBoardButtonState extends State<CustomKeyBoardButton> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;

    return new Container(
        height: 50.0,
        width: _screenWidth / 3,
        child: new OutlineButton(
          // 直角
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0)),
          // 边框颜色
          borderSide: new BorderSide(color: Color(0x10333333)),
          child: new Text(
            widget.text,
            style: new TextStyle(color: Color(0xff333333), fontSize: 20.0),
          ),
          onPressed: back,
        ));
  }
}
