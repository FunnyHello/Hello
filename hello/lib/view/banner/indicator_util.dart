import 'package:flutter/material.dart';

class IndicatorUtil {
  static Widget generateIndicatorItem(
      {bool normal = true,
      double indicatorWidthSize = 8.0,
      double indicatorHeightSize = 8.0}) {
    return Container(
      width: indicatorWidthSize,
      height: indicatorHeightSize,
      decoration: BoxDecoration(
        //设置形状为圆形
        shape: BoxShape.circle,
        //shape: BoxShape.rectangle,
        //设置弧角
        //borderRadius: BorderRadius.circular(3.0),
        color: normal ? Colors.white : Colors.red,
      ),
    );
  }
}
