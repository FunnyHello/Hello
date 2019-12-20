import 'package:flutter/material.dart';
import 'package:hello/view/codeInput/custom_key_board_button.dart';
import 'package:hello/view/codeInput/key_event.dart';

class MyKeyboard extends StatefulWidget {
  final callback;

  MyKeyboard(this.callback);

  @override
  State<StatefulWidget> createState() {
    return new MyKeyboardStat();
  }
}

class MyKeyboardStat extends State<MyKeyboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 定义 确定 按钮 接口  暴露给调用方
  ///回调函数执行体
  var backMethod;

  void onCommitChange() {
    widget.callback(KeyEvent("commit"));
  }

  void onOneChange(BuildContext cont) {
    widget.callback(KeyEvent("1"));
  }

  void onTwoChange(BuildContext cont) {
    widget.callback(KeyEvent("2"));
  }

  void onThreeChange(BuildContext cont) {
    widget.callback(KeyEvent("3"));
  }

  void onFourChange(BuildContext cont) {
    widget.callback(KeyEvent("4"));
  }

  void onFiveChange(BuildContext cont) {
    widget.callback(KeyEvent("5"));
  }

  void onSixChange(BuildContext cont) {
    widget.callback(KeyEvent("6"));
  }

  void onSevenChange(BuildContext cont) {
    widget.callback(KeyEvent("7"));
  }

  void onEightChange(BuildContext cont) {
    widget.callback(KeyEvent("8"));
  }

  void onNineChange(BuildContext cont) {
    widget.callback(KeyEvent("9"));
  }

  void onZeroChange(BuildContext cont) {
    widget.callback(KeyEvent("0"));
  }

  /// 点击删除
  void onDeleteChange() {
    widget.callback(KeyEvent("del"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
      width: double.infinity,
      height: 250.0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 30.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              '下滑隐藏',
              style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),

          ///  键盘主体
          Column(
            children: <Widget>[
              ///  第一行
              Row(
                children: <Widget>[
                  CustomKeyBoardButton(
                      text: '1', callback: (val) => onOneChange(context)),
                  CustomKeyBoardButton(
                      text: '2', callback: (val) => onTwoChange(context)),
                  CustomKeyBoardButton(
                      text: '3', callback: (val) => onThreeChange(context)),
                ],
              ),

              ///  第二行
              Row(
                children: <Widget>[
                  CustomKeyBoardButton(
                      text: '4', callback: (val) => onFourChange(context)),
                  CustomKeyBoardButton(
                      text: '5', callback: (val) => onFiveChange(context)),
                  CustomKeyBoardButton(
                      text: '6', callback: (val) => onSixChange(context)),
                ],
              ),

              ///  第三行
              Row(
                children: <Widget>[
                  CustomKeyBoardButton(
                      text: '7', callback: (val) => onSevenChange(context)),
                  CustomKeyBoardButton(
                      text: '8', callback: (val) => onEightChange(context)),
                  CustomKeyBoardButton(
                      text: '9', callback: (val) => onNineChange(context)),
                ],
              ),

              ///  第四行
              Row(
                children: <Widget>[
                  CustomKeyBoardButton(
                      text: '删除', callback: (val) => onDeleteChange()),
                  CustomKeyBoardButton(
                      text: '0', callback: (val) => onZeroChange(context)),
                  CustomKeyBoardButton(
                      text: '确定', callback: (val) => onCommitChange()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
