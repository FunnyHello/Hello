import 'package:flutter/material.dart';

class MyTextView extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final double height;
  final String text;

  MyTextView({
    Key key,
    this.backgroundColor,
    this.width,
    this.height,
    this.text,
    TextStyle textStyle,
    Image backgroundImage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTextViewState();
  }
}
class _MyTextViewState extends State<MyTextView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor ?? Colors.transparent,
      child: textViewUi(),
    );
  }

  Widget textViewUi() {
    return Container(

    );
  }
}
