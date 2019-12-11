import 'package:flutter/material.dart';
import 'package:hello/view/country/is_uspension_bean.dart';
import 'package:hello/view/country/suspension_view.dart';

import 'index_bar.dart';


//为listview生成子级。
typedef Widget ItemWidgetBuilder(BuildContext context, ISuspensionBean model);

//生成IndexBar
typedef Widget IndexBarBuilder(
    BuildContext context, List<String> tags, IndexBarTouchCallback onTouch);

// 生成索引提示
typedef Widget IndexHintBuilder(BuildContext context, String hint);

// 头部.
class _Header extends ISuspensionBean {
  String tag;

  @override
  String getSuspensionTag() => tag;

  @override
  bool get isShowSuspension => false;
}

class AzListView extends StatefulWidget {
  AzListView(
      {Key key,
        this.data,
        this.topData,
        this.itemBuilder,
        this.controller,
        this.physics,
        this.shrinkWrap = true,
        this.padding = EdgeInsets.zero,
        this.suspensionWidget,
        this.isUseRealIndex = true,
        this.itemHeight = 50,
        this.suspensionHeight = 40,
        this.onSusTagChanged,
        this.header,
        this.indexBarBuilder,
        this.indexHintBuilder,
        this.showIndexHint = true})
      : assert(itemBuilder != null),
        super(key: key);

  final List<ISuspensionBean> data;

  //不参与排序的数据（头部推荐数据）
  final List<ISuspensionBean> topData;

  final ItemWidgetBuilder itemBuilder;

  final ScrollController controller;

  final ScrollPhysics physics;

  final bool shrinkWrap;

  final EdgeInsetsGeometry padding;

  //悬浮小部件
  final Widget suspensionWidget;

  //使用实际索引数据。（false:使用索引数据定义）
  final bool isUseRealIndex;

  //item 高
  final int itemHeight;

  //悬浮控件高度
  final int suspensionHeight;

  final ValueChanged<String> onSusTagChanged;

  final AzListViewHeader header;

  final IndexBarBuilder indexBarBuilder;

  final IndexHintBuilder indexHintBuilder;

  final bool showIndexHint;

  @override
  State<StatefulWidget> createState() {
    return new _AzListViewState();
  }
}

class _AzListViewState extends State<AzListView> {
  Map<String, int> _suspensionSectionMap = Map();
  List<ISuspensionBean> _cityList = List();
  List<String> _indexTagList = List();
  bool _isShowIndexBarHint = false;
  String _indexBarHint = "";

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _onIndexBarTouch(IndexBarDetails model) {
    setState(() {
      _indexBarHint = model.tag;
      _isShowIndexBarHint = model.isTouchDown;
      int offset = _suspensionSectionMap[model.tag];
      if (offset != null) {
        _scrollController.jumpTo(offset
            .toDouble()
            .clamp(.0, _scrollController.position.maxScrollExtent));
      }
    });
  }

  void _init() {
    _cityList.clear();
    if (widget.topData != null && widget.topData.isNotEmpty) {
      _cityList.addAll(widget.topData);
    }
    List<ISuspensionBean> list = widget.data;
    if (list != null && list.isNotEmpty) {
//      SuspensionUtil.sortListBySuspensionTag(list);
      _cityList.addAll(list);
    }

    SuspensionUtil.setShowSuspensionStatus(_cityList);

    if (widget.header != null) {
      _cityList.insert(0, _Header()..tag = widget.header.tag);
    }
    _indexTagList.clear();
    if (widget.isUseRealIndex) {
      _indexTagList.addAll(SuspensionUtil.getTagIndexList(_cityList));
    } else {
      _indexTagList.addAll(INDEX_DATA_DEF);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    var children = <Widget>[
      SuspensionView(
        data: widget.header == null ? _cityList : _cityList.sublist(1),
        contentWidget: ListView.builder(
            controller: _scrollController,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            itemCount: _cityList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 && _cityList[index] is _Header) {
                return SizedBox(
                    height: widget.header.height.toDouble(),
                    child: widget.header.builder(context));
              }
              return widget.itemBuilder(context, _cityList[index]);
            }),
        suspensionWidget: widget.suspensionWidget,
        controller: _scrollController,
        suspensionHeight: widget.suspensionHeight,
        itemHeight: widget.itemHeight,
        onSusTagChanged: widget.onSusTagChanged,
        header: widget.header,
        onSusSectionInited: (Map<String, int> map) =>
        _suspensionSectionMap = map,
      )
    ];

    Widget indexBar;
    if (widget.indexBarBuilder == null) {
      indexBar = IndexBar(
        data: _indexTagList,
        width: 36,
        onTouch: _onIndexBarTouch,
      );
    } else {
      indexBar = widget.indexBarBuilder(
        context,
        _indexTagList,
        _onIndexBarTouch,
      );
    }
    children.add(Align(
      alignment: Alignment.centerRight,
      child: indexBar,
    ));
    Widget indexHint;
    if (widget.indexHintBuilder != null) {
      indexHint = widget.indexHintBuilder(context, '$_indexBarHint');
    } else {
      indexHint = Card(
        color: Colors.black54,
        child: Container(
          alignment: Alignment.center,
          width: 80.0,
          height: 80.0,
          child: Text(
            '$_indexBarHint',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    if (_isShowIndexBarHint && widget.showIndexHint) {
      children.add(Center(
        child: indexHint,
      ));
    }

    return new Stack(children: children);
  }
}
