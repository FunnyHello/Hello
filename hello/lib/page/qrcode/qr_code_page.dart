
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';

class QrCodePage extends BaseStatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QrCodePageState();
  }

}

class QrCodePageState extends BaseState<QrCodePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("扫码", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: initView(),
    );
  }

  initView() {

  }
}