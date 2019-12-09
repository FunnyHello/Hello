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
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (BuildContext context) {
//                  return BPage();
//                }));

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return BPage();
                }));
              },
              child: Text('跳转B页面'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //跳转B并销毁前面所有页面
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return BPage();
                    }), (route) => route == null);
              },
              child: Text('跳转B并销毁前面所有页面'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                //跳转并销毁当前页
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return BPage();
                    }), result: '{result: pushReplacement}');


              },
              child: Text('跳转B并销毁当前页面'),
            ),
          ),

        ],
      ),
    );
  }
}
