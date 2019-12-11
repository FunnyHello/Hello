import 'package:flutter/widgets.dart';

abstract class ISuspensionBean {
  bool isShowSuspension;

  String getSuspensionTag(); //Suspension Tag
}

// ListView头.
class AzListViewHeader {
  AzListViewHeader({
    @required this.height,
    @required this.builder,
    this.tag = "↑",
  });

  final int height;
  final String tag;
  final WidgetBuilder builder;
}

class SuspensionUtil {
  /// 根据[A-Z]排序。
  static void sortListBySuspensionTag(List<ISuspensionBean> list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      if (a.getSuspensionTag() == "@" || b.getSuspensionTag() == "#") {
        return -1;
      } else if (a.getSuspensionTag() == "#" || b.getSuspensionTag() == "@") {
        return 1;
      } else {
        return a.getSuspensionTag().compareTo(b.getSuspensionTag());
      }
    });
  }

  /// 获取索引列表。
  static List<String> getTagIndexList(List<ISuspensionBean> list) {
    List<String> indexData = new List();
    if (list != null && list.isNotEmpty) {
      String tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].getSuspensionTag();
        if (tag.length > 2) tag = tag.substring(0, 2);
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  /// 设置显示悬停Header状态。
  static void setShowSuspensionStatus(List<ISuspensionBean> list) {
    if (list == null || list.isEmpty) return;
    String tempTag;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].getSuspensionTag();
      if (tempTag != tag) {
        tempTag = tag;
        list[i].isShowSuspension = true;
      } else {
        list[i].isShowSuspension = false;
      }
    }
  }
}