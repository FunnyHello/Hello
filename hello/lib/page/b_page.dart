import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/page/home_page.dart';

class BPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BPageState();
  }
}

class _BPageState extends BaseState<BPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('测试页面B'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //跳转并销毁当前页
                Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                ), (route) => route == null);
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
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
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('销毁当前页面'),
            ),
          ),
        ],
      ),
    );
  }
}
