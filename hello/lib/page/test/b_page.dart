import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/page/home/home_page.dart';

class BPage extends BaseStatefulWidget {
  const BPage({Key key, @required this.initValue: 0}) : super(key: key);
  final int initValue;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BPageState();
  }
}

/// 创建并打开：initState->didChangeDependencies->build.
/// 横竖屏切换：didUpdateWidget->build  当前值保留
/// 离开页面：deactivate->dispose 重新进入init重新初始化
/// 热重载执行：reassemble->didUpdateWidget->build
/// 调用setState->build

class _BPageState extends BaseState<BPage> {
//*********************************************生命周期
  int _couter;

  /// 初始化调用
  @override
  void initState() {
    super.initState();
    _couter = widget.initValue;
    print('initState$_couter');
  }

  /// State对象依赖发生变化调用；系统语言、主题修改，系统也会通知调用
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  /// 热重载会被调用，在release下永远不会被调用
  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print('reassemble');
  }

  /// 新旧Widget的key、runtimeType不变时调用。也就是Widget.canUpdate=>true
  @override
  void didUpdateWidget(BPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  /// State在树种移除调用
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  /// State在树中永久移除调用，相当于释放
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
  }

  /// 用于子树的渲染
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('测试页面B'),
      ),
      body: initView(),
    );
  }

  initView() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: RaisedButton(
            onPressed: () {
              //跳转并销毁当前页
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomePage();
                },
              ), (route) => route == null);
            },
            child: Text('跳转首页'),
          ),
        ),
        Container(
          //FlatButton(它会跟随Container的尺寸属性适应)
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: RaisedButton(
            onPressed: () {
              //销毁当前页面
              Navigator.pop(context);
            },
            child: Text('销毁当前页面'),
          ),
        ),
        FlatButton(
          child: Text('$_couter'),
          onPressed: () {
            setState(() {
              ++_couter;
            });
          },
        ),
      ],
    );
  }
}
