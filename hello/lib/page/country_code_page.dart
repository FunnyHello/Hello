import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/view/country/az_list_view.dart';
import 'package:hello/view/country/country_code.dart';
import 'package:hello/view/country/is_uspension_bean.dart';
import 'package:lpinyin/lpinyin.dart';

class CountryCodePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CountryCodePageState();
  }
}

class CountryCodePageState extends BaseState<CountryCodePage> {
  List<CountryCode> _elements = List();
  List<CountryCode> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("滑稽"),
        centerTitle: true,
      ),
      body: initView(),
    );
  }

  Widget initView() {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: AzListView(
              data: _elements,
              topData: _hotCityList,
              itemBuilder: (context, model) => _buildListItem(model),
              suspensionWidget: _buildSusWidget(_suspensionTag),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: _onSusTagChanged,
              //showCenterTip: false,
            )),
      ],
    );
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/data/country.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['country'];
      list.forEach((value) {
        _elements.add(CountryCode(
            name: value['name'],
            code: value['code'],
            dialCode: value['dial_code']));
      });
      _handleList(_elements);

      _hotCityList.add(CountryCode(name: "中国", tagIndex: "★"));

      setState(() {
        _suspensionTag = _hotCityList[0].getSuspensionTag();
      });
    });
  }

  void _handleList(List<CountryCode> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_elements);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    susTag = (susTag == "★" ? "热门地区" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(CountryCode model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★" ? "热门地区" : susTag);
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              showToast("国家：" +
                  model.name +
                  " 国家代码：" +
                  model.code +
                  " 区号：" +
                  model.dialCode);
              Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }
}
