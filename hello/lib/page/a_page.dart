import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/page/b_page.dart';
import 'package:hello/utils/toast_util.dart';

class APage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _APageState();
  }
}

class _APageState extends BaseState<APage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('测试页面A'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return BPage();
                }));
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('跳转B页面'),
            ),
          ),
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //跳转并销毁当前页
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return BPage();
                  },
                ), (route) => route == null);
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('跳转B并销毁当前页面'),
            ),
          ),
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //测试国际化
                showToast(getLanguage().hello_world);
              },
              child: Text('测试'),
            ),
          ),
        ],
      ),
    );
  }
}
