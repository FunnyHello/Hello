import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/bean/home_banner.dart';
import 'package:hello/page/home_tab_one_page.dart';
import 'package:hello/page/home_tab_three_page.dart';
import 'package:hello/page/home_tab_two_page.dart';
import 'package:hello/page/personal_center_page.dart';
import 'package:hello/view/toast.dart';
import 'package:hello/view/my_drawer.dart';

/**
 * StatelessWidget
 * 用于定义不需要可变状态控件（无状态控件）
 * 通过构建其它控件来实现ui效果
 */
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('这是个首页'),
//      ),
//    );
//  }
//}

/**
 * StatefulWidget
 * 用于定义可变状态控件
 * 在生命周期内状态可改变
 * 在状态发生改变时调用State.setState方法通知框架状态改变
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //banner数据
  List<HomeBanner> listData = <HomeBanner>[];

  //当前指示器
  int currentIndex = 0;

  //首页tab
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));
  var appBarTitles = ['资讯', '发现', '我的'];
  var tabImages;
  var _pageList;
  //在这里初始化数据
  @override
  void initState() {
    super.initState();
    initData(); //初始化数据
  }

  void initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/icon_news_off.png'),
          getTabImage('images/icon_news_on.png'),
        ],
        [
          getTabImage('images/icon_find_off.png'),
          getTabImage('images/icon_find_on.png'),
        ],
        [
          getTabImage('images/icon_mine_off.png'),
          getTabImage('images/icon_mine_on.png'),
        ]
      ];
    }
    _pageList = [
      HomeTabOnePage(),
      HomeTabTwoPage(),
      HomeTabThreePage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    //销毁时调用
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    //MediaQuery.of(context)这个里面还有其他信息，你们自行发掘吧
    // appbar 高度
    double _kLeadingWidth = kToolbarHeight;

    return new Scaffold(
//      //PreferredSize可以实现自定义appBar
//      appBar: new MyAppBar(
//        child: new Container(
//          //double.infinity为撑满父控件
//          height: double.infinity,
//          child: new Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Offstage(
//                //false为显示，true不显示
//                offstage: false,
//                child: Text("返回"),
//              ),
//              //测试国际化
//              Text(MyLocalizations.of(context).home_title),
//              Offstage(
//                //false为显示，true不显示
//                offstage: false,
//                child: new GestureDetector(
//                  child: new Text("UI测试"),
//                  onTap: () {
//                    Toast.toast(context, "点击了MENU");
//                    Navigator.of(context).push(
//                        new MaterialPageRoute(builder: (BuildContext context) {
//                      return new PersonalCenterPage(
//                        "",
//                        object: null,
//                      );
//                    }));
//                  },
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//      appBar: PreferredSize(
//        child: new Container(
//          color: Colors.blue, //背景颜色
//        ),
//        preferredSize: const Size.fromHeight(48.0),
//      ),

      appBar: new AppBar(
        title: new Text('这是个首页'),
        actions: <Widget>[
          //标题右边添加menu按钮
//            new IconButton(
//                icon: new Icon(Icons.list), onPressed: _rightOnPressed),
        ],
      ),
      body: new PageView.builder(
//        //禁止滑动
//        physics: new NeverScrollableScrollPhysics(),
        //页面切换时调用
        onPageChanged: _pageChange,
        //PageView的控制器
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return _pageList[index];
        },
        //设置页数
        itemCount: 3,

      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
//              //自己定义icon但是颜色会丢失
//              icon: new ImageIcon(new AssetImage("images/icon.png")),
//              title: new Text("首页")
              icon: getTabIcon(0),
              title: getTabTitle(0)),
          BottomNavigationBarItem(
//          icon: new Icon(Icons.message),
//          title: new Text("我的"),
              icon: getTabIcon(1),
              title: getTabTitle(1)),
          BottomNavigationBarItem(
              icon: getTabIcon(2),
              title: getTabTitle(2)),
        ],
        currentIndex: _currentPageIndex,
        onTap: onTap,
      ),
//      //右边侧滑抽屉控件
//      endDrawer: new MyDrawer(),
      //左边侧滑抽屉控件
      drawer: new MyDrawer(),
    );
  }

//下部分tab图标++++++++++++++++++++++++
  Image getTabIcon(int curIndex) {
    if (curIndex == _currentPageIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _currentPageIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  //++++++++++++++++++++++++

  // bottomnaviagtionbar 和 pageview 的联动
  void onTap(int index) {
    _currentPageIndex = index;
    // 过pageview的pagecontroller的animateToPage方法可以跳转
    //带过渡动画的切换
    _pageController.animateToPage(_currentPageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
//    //无动画的切换
//    _pageController.jumpToPage(index);
  }

  //滑动事件
  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  void _rightOnPressed() {
    //右边按键点击事件
    Toast.toast(context, "点击了MENU");
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new PersonalCenterPage(
        "",
        object: null,
      );
    }));
  }

//  Widget threeView() {
//    return new PageView.builder(
//      controller: PageController(
//        //设置视觉分数（默认为1）
//        viewportFraction: 0.8,
//        //默认第一页（从0开始）
//        initialPage: 1,
//      ),
//      //页面切换时调用
////      onPageChanged: (),
//      //设置为3页，当显示当前页面时加载上一页和下一页
//      itemCount: 3,
//      itemBuilder: (BuildContext context, int index) {
//        //两边有间隙的banner
//        return Padding(
//          padding: EdgeInsets.symmetric(
//            vertical: 16.0,
//            horizontal: 8.0,
//          ),
//          child: Material(
//            //添加阴影
//            elevation: 5.0,
//            borderRadius: BorderRadius.circular(8.0),
//            child: new Image.asset(
//              'images/fuchsia.jpg',
//              //尽可能小，同时仍然覆盖整个目标框。
//              fit: BoxFit.cover,
//            ),
//            //decorationBox,
//          ),
//        );
//      },
//    );
//  }

}