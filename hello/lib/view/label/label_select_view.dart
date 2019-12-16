import 'package:flutter/material.dart';
import 'package:hello/utils/type_utils.dart';

import 'base_select_entity.dart';
///这个控件必须在Scaffold里面使用
class LableSelectView<T extends BaseSelectEntity> extends StatefulWidget {
  //标签的list
  List<T> dataList;
  bool isCheckbox = false;

  final Function(List<T>) onSelectionChanged;

  LableSelectView(this.dataList, {this.onSelectionChanged, this.isCheckbox});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LableSelectViewState();
  }
}

class _LableSelectViewState<T extends BaseSelectEntity>
    extends State<LableSelectView> {
  @override
  Widget build(BuildContext context) {
    ///Wrap是个流式布局标签自适应换行靠这个控件
    return Wrap(
      alignment: WrapAlignment.start,

      ///主轴子控件的间距
      spacing: 5,

      ///交叉轴子控件的间距
      runSpacing: 1,
      children: _initView(),
    );
  }

  _initView() {
    List<Widget> choices = List();

    for (int i = 0; i < widget.dataList.length; i++) {
      choices.add(
        Container(
          ///ChoiceChip单选按钮,实现标签效果
          child: ChoiceChip(
            label: Text(
              widget.dataList[i].title,
            ),
            //未选定的时候背景
            selectedColor: Colors.white,
            //被禁用得时候背景
            disabledColor: Colors.grey[300],
            //label样式
            labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
//              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
              side: BorderSide(color: Colors.black, width: 0.5),
            ),
            onSelected: (bool value) {
              setState(() {
                ///取出选中的控件
                List<T> selectList = List();
                selectList.clear();

                if (isTrue(widget.isCheckbox)) {
                  ///多选
                  ///bool变量会为null？？？我也不知道为什么
                  widget.dataList[i].isSelection =
                      !isTrue(widget.dataList[i].isSelection);

                  widget.dataList.forEach((item) {
                    if (item.isSelection != null || item.isSelection != false) {
                      selectList.add(item);
                    }
                  });
                } else {
                  ///单选
                  for (int j = 0; j < widget.dataList.length; j++) {
                    widget.dataList[j].isSelection = false;
                  }
                  widget.dataList[i].isSelection = true;
                  selectList.add(widget.dataList[i]);
                }

                widget.onSelectionChanged(selectList);
              });
            },
            //是否可被选中
            selected: !isTrue(widget.dataList[i].isSelection),
          ),
        ),
      );
    }
    return choices;
  }
}
