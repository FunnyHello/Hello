import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';

class SkiddingDeletionPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SkiddingDeletionPageState();
  }
}

class SkiddingDeletionPageState extends BaseState<SkiddingDeletionPage> {
  final List<String> items = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    items.add("测试1");
    items.add("测试2");
    items.add("测试3");
    items.add("测试4");
    items.add("测试5");

    return Scaffold(
      appBar: AppBar(
        title: Text('测试删除'),
      ),
      body:  initView(),
    );
  }

  initView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        //通过拖动来删除小部件的widget
        return Dismissible(
            //如果Dismissible是一个列表项 它必须有一个key 用来区别其他项
            key: Key(item),
            //在child被取消时调用
            onDismissed: (direction) {
              items.removeAt(index);
              //这个和Android的SnackBar差不多
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            //如果指定了background 他将会堆叠在Dismissible child后面 并在child移除时暴露
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              title: Text("$item"),
            ));
      },
    );
  }
}
