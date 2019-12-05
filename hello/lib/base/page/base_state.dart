
import 'package:flutter/cupertino.dart';
import 'package:hello/language/globalization.dart';
abstract class BaseState<T extends StatefulWidget> extends State<T>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  MyLocalizations getLanguage(){
   return getMyLocalizations(context);
  }
}