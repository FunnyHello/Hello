import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/view/slide_button.dart';

class SideslipItemPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SideslipItemPageState();
  }
}
class SideslipItemPageState extends BaseState<SideslipItemPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('测试侧滑item'),
      ),
      body: initView(),
    );
  }

  initView() {
    return ListView(
      children: getSlides(),
    );
  }

  List<SlideButton> list;

  List<SlideButton> getSlides() {
    list = List<SlideButton>();
    for (var i = 0; i < 10; i++) {
      var key = GlobalKey<SlideButtonState>();
      var slide = SlideButton(
        key: key,
        singleButtonWidth: 80,
        onSlideStarted: () {
          list.forEach((slide) {
            if (slide.key != key) {
              slide.key.currentState?.close();
            }
          });
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text("测试"),
          ),
        ),
        //滑动开显示的button
        buttons: <Widget>[
          buildAction(key, "置顶", Colors.grey[400], () {
            showToast("置顶");
            key.currentState.close();
          }),
          buildAction(key, "标为未读", Colors.amber, () {
            showToast("标为未读");
            key.currentState.close();
          }),
          buildAction(key, "删除", Colors.red, () {
            showToast("删除");
            key.currentState.close();
          }),
        ],
      );
      list.add(slide);
    }
    return list;
  }

  //构建button
  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        color: color,
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
