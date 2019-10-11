import 'package:flutter/material.dart';
import 'package:hello/utils/toast_util.dart';

class BoxTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoxTestPageState();
  }
}

class _BoxTestPageState extends State<BoxTestPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('这是个测试弹框的页面'),
        actions: <Widget>[
          GestureDetector(
            //触摸事件（包裹需要交互的控件）
            child: Center(
              child: Text("这是个点击弹出POP"),
            ),
            onTap: () async {
              final result = await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(1, 80.0, 0, 0),
                items: <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '一',
                    child: Container(
                      color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      child: Text('第一个'),
                    ),
                  ),
                  PopupMenuDivider(height: 1.0),
                  PopupMenuItem<String>(
                    value: '二',
                    child: Center(
                      child: Text('第二个'),
                    ),
                  ),
                  PopupMenuDivider(height: 1.0),
                  PopupMenuItem<String>(
                    value: '三',
                    child: Center(
                      child: Text('第三个'),
                    ),
                  ),
                  PopupMenuDivider(height: 1.0),
                  PopupMenuItem<String>(
                    value: '四',
                    child: Center(
                      child: Text('第四个'),
                    ),
                  )
                ],
              );
            },
          ),
        ],
//        actions: <Widget>[
//          //标题右边添加menu按钮
//          _dividerPopMenu(),
//        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Text('测试原生弹框'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                showBottomFrame();
              },
              child: Text('测试底部弹框'),
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text("标题"),
                content: Text("内容"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("左边按钮"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      ToastUtil.showMsg("点击了左边按钮");
                    },
                  ),
                  FlatButton(
                    child: Text("右边按钮"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      ToastUtil.showMsg("点击了右边按钮");
                    },
                  )
                ]));
  }

  Widget _dividerPopMenu() {
    return PopupMenuButton<String>(
        child: Center(
          child: Text("点击弹出选择框"),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(value: '一', child: Text('第一个')),
              PopupMenuDivider(height: 1.0),
              PopupMenuItem<String>(value: '二', child: Text('第二个')),
              PopupMenuDivider(height: 1.0),
              PopupMenuItem<String>(value: '三', child: Text('第三个')),
              PopupMenuDivider(height: 1.0),
              PopupMenuItem<String>(value: '四', child: Text('第四个'))
            ],
        onSelected: (String value) {
          ToastUtil.showMsg("点到了");
        });
  }

  void showBottomFrame() {
    showModalBottomSheet<void>(context: context, builder: _bottomSheetBuilder);
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    return Container(
        height: 182.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: Text("这里可以点"),
                  ),
                ),
                onTap: () {
                  ToastUtil.showMsg("点到了");
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ],
          ),
        ));
  }
}
