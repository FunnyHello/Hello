
import 'package:flutter/cupertino.dart';
import 'package:hello/language/globalization.dart';

/**
 *  设置with AutomaticKeepAliveClientMixin
 *  bool get wantKeepAlive => true;
 *  最后在build中加入super.build(context);
 *  防止tab切换时initState反复执行
 */

abstract class BaseState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return null;
  }
  MyLocalizations getLanguage(){
   return getMyLocalizations(context);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}