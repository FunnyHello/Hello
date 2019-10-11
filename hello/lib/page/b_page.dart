import 'package:flutter/material.dart';
import 'package:hello/page/home_page.dart';

class BPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BPageState();
  }
}

class _BPageState extends State<BPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('测试页面B'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //跳转并销毁当前页
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                ), (route) => route == null);
              },
              child: Text('跳转首页'),
            ),
          ),
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //销毁当前页面
                Navigator.pop(context);
              },
              child: Text('销毁当前页面'),
            ),
          ),
        ],
      ),
    );
  }
}
