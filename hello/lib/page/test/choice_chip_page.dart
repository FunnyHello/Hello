import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/view/label/label_select_view.dart';
import 'package:hello/view/label/select_entity.dart';

class ChoiceChipPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChoiceChipPageState();
  }
}

class ChoiceChipPageState extends BaseState<ChoiceChipPage> {
  List<SelectEntity> allList = List();
  List<SelectEntity> allListCheckbox = List();

  bool checkValue1 = true;

  @override
  Widget build(BuildContext context) {
    allList.clear();
    allList.add(SelectEntity("Android1"));
    allList.add(SelectEntity("Android2"));
    allList.add(SelectEntity("Android3"));
    allList.add(SelectEntity("Android4454436456456"));
    allList.add(SelectEntity("Android5"));
    allList.add(SelectEntity("Android64564"));
    allList.add(SelectEntity("Android74564"));
    allList.add(SelectEntity("Android8"));
    allList.add(SelectEntity("Android944"));
    allList.add(SelectEntity("Android10"));
    allListCheckbox.clear();
    allListCheckbox.add(SelectEntity("Android1"));
    allListCheckbox.add(SelectEntity("Android2"));
    allListCheckbox.add(SelectEntity("Android3"));
    allListCheckbox.add(SelectEntity("Android4454436456456"));
    allListCheckbox.add(SelectEntity("Android5"));
    allListCheckbox.add(SelectEntity("Android64564"));
    allListCheckbox.add(SelectEntity("Android74564"));
    allListCheckbox.add(SelectEntity("Android8"));
    allListCheckbox.add(SelectEntity("Android944"));
    allListCheckbox.add(SelectEntity("Android10"));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('测试'),
      ),
      body: initView(),
    );
  }

  Widget initView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            width: MediaQuery.of(context).size.width,
            child: LableSelectView(
              allList,
              onSelectionChanged: (selectedList) {
                //这个接口不能刷新界面
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            width: MediaQuery.of(context).size.width,
            child: LableSelectView(
              allListCheckbox,
              onSelectionChanged: (selectedList) {
                //这个接口不能刷新界面
              },
              isCheckbox: true,
            ),
          ),
          Switch(
              value: checkValue1,
              //回调，改变状态
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
          SwitchListTile(
              title: Text("开关"),
              value: checkValue1,
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
          Checkbox(
              //选中的✔ 颜色
              checkColor: Colors.yellowAccent,
              //选中的框框背景颜色
              activeColor: Colors.grey,
              value: checkValue1,
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
          CheckboxListTile(
              title: Text("复选按钮"),
              value: checkValue1,
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
          Radio(
              value: 1,
              groupValue: checkValue1,
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
          RadioListTile(
              title: Text("单选按钮"),
              value: 2,
              groupValue: checkValue1,
              onChanged: (value) {
                setState(() {
                  checkValue1 = value;
                });
              }),
        ],
      ),
    );
  }
}
