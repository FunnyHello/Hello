import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/bean/home_banner.dart';
import 'package:hello/page/home_tab_one_page.dart';
import 'package:hello/page/home_tab_three_page.dart';
import 'package:hello/page/home_tab_two_page.dart';
import 'package:hello/page/personal_center_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/view/my_drawer.dart';

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

class HomePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage> {
  //banner数据
  List<HomeBanner> listData = <HomeBanner>[];

  //当前指示器
  int currentIndex = 0;

  //首页tab
  int _currentPageIndex = 0;
  var _pageController = PageController(initialPage: 0);

  final tabTextStyleNormal = TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = TextStyle(color: const Color(0xff63ca6c));
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
          getTabImage('assets/images/icon_news_off.png'),
          getTabImage('assets/images/icon_news_on.png'),
        ],
        [
          getTabImage('assets/images/icon_find_off.png'),
          getTabImage('assets/images/icon_find_on.png'),
        ],
        [
          getTabImage('assets/images/icon_mine_off.png'),
          getTabImage('assets/images/icon_mine_on.png'),
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

  Future<bool> _requestPop() {
//    _showDialog();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    //MediaQuery.of(context)这个里面还有其他信息，你们自行发掘吧
    // appbar 高度
    double _kLeadingWidth = kToolbarHeight;
    //WillPopScope监听左上角返回和实体返回
    DateTime lastPopTime;
    return WillPopScope(
      onWillPop: () {
        // 点击返回键的操作
        if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          showToast("再按一次退出");
        }else{
          lastPopTime = DateTime.now();
          SystemNavigator.pop();
          // 退出app
        }
        //拦截退出按钮
        return Future.value(false);
      },
      child: Scaffold(
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

        appBar: AppBar(
          centerTitle: true,
          title: Text('这是个首页'),
          //添加左边按钮
//        leading: IconButton(icon: Icon(Icons.star)),
          //左边栏按钮呼出侧滑菜单
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.face),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: <Widget>[
            //标题右边添加menu按钮
//            IconButton(
//                icon: Icon(Icons.list), onPressed: _rightOnPressed),
          ],
        ),
        body: PageView.builder(
//        //禁止滑动
//        physics: NeverScrollableScrollPhysics(),
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
        bottomNavigationBar: BottomNavigationBar(
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
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          currentIndex: _currentPageIndex,
          onTap: onTap,
        ),
//      //右边侧滑抽屉控件
//      endDrawer: new MyDrawer(),
        //左边侧滑抽屉控件
        drawer: MyDrawer(),
      ),
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
    Fluttertoast.showToast(
        msg: "点击了MENU",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
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
