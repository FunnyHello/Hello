import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/utils/toast_util.dart';

class PersonalCenterPage extends BaseStatefulWidget {
  final String id;
  final Object object;

  PersonalCenterPage(
    this.id, {
    @required this.object,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalCenterPageState();
  }
}

class _PersonalCenterPageState extends BaseState<PersonalCenterPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('UI测试'),
      ),
      /**
       * 居中布局
       * Center
       *
       * 给一个组件添加 padding, margins, 边界（borders）, 背景颜色或其它装饰（decorations）。
       * Container
       *
       * 将多个widget放在一个可滑动的表格中。
       * GridView
       *
       * 将多个widget放在一个可滑动的列表中。
       * ListView
       *
       * 在一个widget上面盖上另一个widget。
       * Stack
       *
       * -- Material Components --
       *
       * 将一些相近的信息装进一个有圆角和阴影的盒子里。
       * Card
       *
       *  一个Row中装载最多3行文字；可选则在前面或尾部添加图标。
       *  ListTile
       */
      body: Container(
        color: Colors.cyanAccent, //背景颜色
        /**
         * children可承载多个子控件
         * child可承载单个子控件
         */
//        child: transverseUi(),
//        child: portraitUi(),
//        child: portraitWeightUi(),
//        child: nestingUi(),
        child: gridViewUi(),
//        child: listViewUi(),
//        child: stackUi(),
      ),

      //body: Image.network("https://fuchsia-china.com/wp-content/uploads/2018/11/fuchsia.jpg"),//加载网络图片
      //body: Image.asset('images/fuchsia.jpg'),//加载本地图片
    );
  }

  //显示一个横向ui
  Widget transverseUi() {
    return Row(
      //横向显示控件
//      mainAxisSize: MainAxisSize.max, //撑满
//      mainAxisSize: MainAxisSize.min, //包裹
//      mainAxisAlignment: MainAxisAlignment.start, //将子控件放在主轴的起始位置。
//      mainAxisAlignment: MainAxisAlignment.end, //将子控件放在主轴末尾。
//      mainAxisAlignment: MainAxisAlignment.center, //将子控件放在主轴中间位置。

      // 将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，
      // 两端的子控件都靠近首尾，没有间隙。
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // 将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，
      // 两端的子控件都靠近首尾，首尾子控件的空白区域为1/2。
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，包括首尾
//      mainAxisAlignment: MainAxisAlignment.center,

//    crossAxisAlignment: CrossAxisAlignment.start, // 子控件显示在交叉轴的起始位置。
//    crossAxisAlignment: CrossAxisAlignment.end, //子控件显示在交叉轴的末尾位置。
//    crossAxisAlignment: CrossAxisAlignment.center, //子控件显示在交叉轴的中间位置。
//    crossAxisAlignment: CrossAxisAlignment.stretch, //子控件完全填充交叉轴方向的空间。
//    crossAxisAlignment: CrossAxisAlignment.baseline, //子控件的baseline在交叉轴方向对齐

      children: <Widget>[
        Image.asset('images/icon.png'),
        Image.asset('images/icon.png'),
        Image.asset('images/icon.png'),
      ],
    );
  }

  Widget portraitUi() {
    return new Column(
      //纵向显示控件
//      mainAxisSize: MainAxisSize.max,//撑满
//      mainAxisSize: MainAxisSize.min, //包裹
//      mainAxisAlignment: MainAxisAlignment.start, //将子控件放在主轴的起始位置。
//      mainAxisAlignment: MainAxisAlignment.end, //将子控件放在主轴末尾。
//      mainAxisAlignment: MainAxisAlignment.center, //将子控件放在主轴中间位置。

      // 将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，
      // 两端的子控件都靠近首尾，没有间隙。
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // 将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，
      // 两端的子控件都靠近首尾，首尾子控件的空白区域为1/2。
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //将主轴方向上的空白区域等分，使得子控件之间的空白区域相等，包括首尾
//      mainAxisAlignment: MainAxisAlignment.center,

//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//    crossAxisAlignment: CrossAxisAlignment.start, // 子控件显示在交叉轴的起始位置。
//    crossAxisAlignment: CrossAxisAlignment.end, //子控件显示在交叉轴的末尾位置。
//    crossAxisAlignment: CrossAxisAlignment.center, //子控件显示在交叉轴的中间位置。
//    crossAxisAlignment: CrossAxisAlignment.stretch, //子控件完全填充交叉轴方向的空间。
//    crossAxisAlignment: CrossAxisAlignment.baseline, //子控件的baseline在交叉轴方向对齐
      children: <Widget>[
        Image.asset('images/icon.png'),
        Image.asset('images/fuchsia.jpg'),
        Image.asset('images/icon.png'),
      ],
    );
  }

  Widget portraitWeightUi() {
    return new Column(
      //权重ui测试
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildImage("images/icon.png", color: Colors.blue),
        buildImage("images/icon.png", flex: 2, color: Colors.pinkAccent),
        buildImage("images/icon.png", flex: 3, color: Colors.cyanAccent),
      ],
    );
  }

  /**
   * 封装的
   * icon , 权重 , icon背景色
   */
  Widget buildImage(String image, {int flex = 1, Color color}) {
    return new Expanded(
      child: new Container(
        color: color, //背景颜色
        child: Image.asset(image),
      ),
      flex: flex,
    );
  }

  /**
   *  嵌套ui测试
   */
  Widget nestingUi() {
    var container = Container(
      decoration: BoxDecoration(color: Colors.black26),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              imageExpanded('images/icon.png'),
              imageExpanded('images/icon.png'),
            ],
          ),
          new Row(
            children: <Widget>[
              imageExpanded('images/icon.png'),
              imageExpanded('images/icon.png'),
            ],
          ),
          new Row(
            children: <Widget>[
              imageExpanded('images/icon.png'),
              imageExpanded('images/icon.png'),
            ],
          )
        ],
      ),
    );

    return container;
  }

  Expanded imageExpanded(String img) {
    //扩展行和列的组件
    return new Expanded(
        child: Container(
      //创造一个盒子装饰
      decoration: BoxDecoration(
          //盒子边框(不能与背景颜色color同时使用)
          border: Border.all(width: 10.0, color: Colors.black38),
          //弧角矩阵
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      //外边距
      margin: const EdgeInsets.all(10.0),
      //图片
      child: Image.asset(img),
    ));
  }

  /**
   * GridView.extent
   */
  Widget gridViewUi() {
    //固定横向个数
//    var countGrid = GridView.count(
//      //每行显示个数
//      crossAxisCount: 4,
//      //上下item之间的间距
//      mainAxisSpacing: 4.0,
//      //左右item之间的间距
//      crossAxisSpacing: 4.0,
//      //控件外边距
//      padding: const EdgeInsets.all(10.0),
//      //childAspectRatio: 1.3,
//      children: _buildGridTileList(9),
//    );
//    return countGrid;

    //自适应宽度
    return GridView.extent(
      //item的最大宽度
      maxCrossAxisExtent: 150.0,
      //控件外边距
      padding: const EdgeInsets.all(10.0),
      //上下item之间的间距
      mainAxisSpacing: 5.0,
      //左右item之间的间距
      crossAxisSpacing: 5.0,
      //数据
      children: _buildGridTileList(9),
    );
  }

  List<Container> _buildGridTileList(int count) {
    return List<Container>.generate(
        count,
        (int index) =>
//        new Container(child: new Image.asset('images/pic${index + 1}.jpg'),));

//    new Container(child: new Container(
//      color: Colors.blue, //背景颜色
//      child: new Image.asset('images/icon.png'),
//    ),));
            Container(
              //背景颜色
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/icon.png'),
                  Text("滑稽" + index.toString()),
                ],
              ),
            ));
  }

  Widget listViewUi() {
//    return new ListView(
//      children: listItem(30),
//    );

    return ListView(
      children: listItemCard(30),
    );
  }

  List<Container> listItem(int count) {
    return List<Container>.generate(
        count,
        (int index) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('images/icon.png'),
                  Text("滑稽" + index.toString()),
                ],
              ),
            ));
  }

  /**
   * 测试card(卡片控件)
   */
  List<Widget> listItemCard(int count) {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < count; i++) {
      list.add(Card(
        child: Column(
          children: <Widget>[
//            new Image.asset(
//              'images/fuchsia.jpg',
//            ),
            GestureDetector(
              //触摸事件（包裹需要交互的控件）
              child: Image.asset('images/fuchsia.jpg'),
              onTap: () {
                ToastUtil.showMsg("点击了卡片" + i.toString());
              },
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset('images/icon.png'),
                          onTap: () {
                            ToastUtil.showMsg("点击了图片" + i.toString());
                          },
                        ),

                        GestureDetector(
                          child: Text("滑稽" + i.toString()),
                          onTap: () {
                            ToastUtil.showMsg("点击了滑稽" + i.toString());
                          },
                        ),

//                        Image.asset('images/icon.png'),
//                        Text("滑稽" + i.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    }
    return list;
  }

  /**
   * stack测试（类似帧布局）
   */
  Widget stackUi() {
    //堆栈布局
    var stack = Stack(
      //偏移量（可为负数）
      alignment: const Alignment(0.6, 0.6),
      children: <Widget>[
        //圆形控件
        CircleAvatar(
          backgroundImage: AssetImage('images/fuchsia.jpg'),
          radius: 100.0,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black45),
          child: Text(
            '这是么比？',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.transparent),
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/icon.png'),
            backgroundColor: Colors.transparent,
            radius: 10.0,
          ),
        ),
      ],
    );
    return stack;
  }
}
