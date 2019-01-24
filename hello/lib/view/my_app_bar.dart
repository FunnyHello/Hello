import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 自定义AppBar
 */
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({@required this.child}) : assert(child != null);
  final Widget child;

  @override
  Size get preferredSize {
    //设置最大高度
    return new Size.fromHeight(50.0);
  }

  @override
  State createState() {
    return new MyAppBarState();
  }
}

class MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    //return widget.child;
    return new Container(
        //背景颜色
//        color: Colors.blue,
        //获取主题颜色
        color: Theme.of(context).accentColor,
        child: SafeArea(
          top: true,
          child: widget.child,
        ));
  }
}
