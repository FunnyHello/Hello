import 'package:flutter/material.dart';

import 'is_uspension_bean.dart';


//使list滚动到指定位置
typedef void OnSusSectionCallBack(Map<String, int> map);

//悬浮控件。目前只支持固定高度的项目！
class SuspensionView extends StatefulWidget {
  final List<ISuspensionBean> data;

  //显示内容
  final Widget contentWidget;

  //显示悬浮控件
  final Widget suspensionWidget;

  //ListView的ScrollController.
  final ScrollController controller;

  //悬浮控件高度
  final int suspensionHeight;

  //item 高度.
  final int itemHeight;

  final ValueChanged<String> onSusTagChanged;

  final OnSusSectionCallBack onSusSectionInited;

  final AzListViewHeader header;

  SuspensionView({
    Key key,
    @required this.data,
    @required this.contentWidget,
    @required this.suspensionWidget,
    @required this.controller,
    this.suspensionHeight = 40,
    this.itemHeight = 50,
    this.onSusTagChanged,
    this.onSusSectionInited,
    this.header,
  })  : assert(contentWidget != null),
        assert(controller != null),
        super(key: key);

  @override
  _SuspensionWidgetState createState() => new _SuspensionWidgetState();
}

class _SuspensionWidgetState extends State<SuspensionView> {
  int _suspensionTop = 0;
  int _lastIndex;
  int _suSectionListLength;

  List<int> _suspensionSectionList = new List();
  Map<String, int> _suspensionSectionMap = new Map();

  @override
  void initState() {
    super.initState();
    if (widget.header != null) {
      _suspensionTop = -widget.header.height;
    }
    widget.controller.addListener(() {
      int offset = widget.controller.offset.toInt();
      int _index = _getIndex(offset);
      if (_index != -1 && _lastIndex != _index) {
        _lastIndex = _index;
        if (widget.onSusTagChanged != null) {
          widget.onSusTagChanged(_suspensionSectionMap.keys.toList()[_index]);
        }
      }
    });
  }

  int _getIndex(int offset) {
    if (widget.header != null && offset < widget.header.height) {
      if (_suspensionTop != -widget.header.height &&
          widget.suspensionWidget != null) {
        setState(() {
          _suspensionTop = -widget.header.height;
        });
      }
      return 0;
    }
    for (int i = 0; i < _suSectionListLength - 1; i++) {
      int space = _suspensionSectionList[i + 1] - offset;
      if (space > 0 && space < widget.suspensionHeight) {
        space = space - widget.suspensionHeight;
      } else {
        space = 0;
      }
      if (_suspensionTop != space && widget.suspensionWidget != null) {
        setState(() {
          _suspensionTop = space;
        });
      }
      int a = _suspensionSectionList[i];
      int b = _suspensionSectionList[i + 1];
      if (offset >= a && offset < b) {
        return i;
      }
      if (offset >= _suspensionSectionList[_suSectionListLength - 1]) {
        return _suSectionListLength - 1;
      }
    }
    return -1;
  }

  void _init() {
    _suspensionSectionMap.clear();
    int offset = 0;
    String tag;
    if (widget.header != null) {
      _suspensionSectionMap[widget.header.tag] = 0;
      offset = widget.header.height;
    }
    widget.data?.forEach((v) {
      if (tag != v.getSuspensionTag()) {
        tag = v.getSuspensionTag();
        _suspensionSectionMap.putIfAbsent(tag, () => offset);
        offset = offset + widget.suspensionHeight + widget.itemHeight;
      } else {
        offset = offset + widget.itemHeight;
      }
    });
    _suspensionSectionList
      ..clear()
      ..addAll(_suspensionSectionMap.values);
    _suSectionListLength = _suspensionSectionList.length;
    if (widget.onSusSectionInited != null) {
      widget.onSusSectionInited(_suspensionSectionMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    var children = <Widget>[
      widget.contentWidget,
    ];
    if (widget.suspensionWidget != null) {
      children.add(Positioned(
        ///-0.1修复部分手机丢失精度问题
        top: _suspensionTop.toDouble() - 0.1,
        left: 0.0,
        right: 0.0,
        child: widget.suspensionWidget,
      ));
    }
    return Stack(children: children);
  }
}
