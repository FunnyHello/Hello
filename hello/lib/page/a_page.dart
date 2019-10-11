import 'package:flutter/material.dart';
import 'package:hello/page/b_page.dart';

class APage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _APageState();
  }
}

class _APageState extends State<APage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text('测试页面A'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                     MaterialPageRoute(builder: (BuildContext context) {
                      return  BPage();
                    }));
              },

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
                Navigator.pushAndRemoveUntil(context,
                     MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BPage();
                      },
                    ), (route) => route == null);
              },
              child: Text('跳转B并销毁当前页面'),
            ),
          ),
        ],
      ),
    );
  }
}
