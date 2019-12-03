import 'package:flutter/material.dart';
import 'package:hello/page/box_test_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeTabThreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTabThreePageState();
  }
}

class _HomeTabThreePageState extends State<HomeTabThreePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var qrView = GestureDetector(
      child: Container(
        //子控件对齐方式
        alignment: Alignment.topCenter,
        color: Colors.lightBlueAccent,
        child: QrImage(
//          backgroundColor: Colors.yellow,
          data: "这是个二维码",
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ),
      onTap: () {
      },
    );

    return new Scaffold(
      body: qrView,
    );
  }
}
