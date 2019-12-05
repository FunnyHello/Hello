import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello/bean/home_banner.dart';
import 'package:hello/page/a_page.dart';
import 'package:hello/page/box_test_page.dart';
import 'package:hello/page/web_view_page.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/map_utils.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/view/banner/carousel_slider.dart';
import 'package:hello/view/banner/indicator_util.dart';

class HomeTabOnePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabOnePageState();
  }
}

class _HomeTabOnePageState extends State<HomeTabOnePage> {
  //banner数据
  List<HomeBanner> listData = <HomeBanner>[];

  //当前指示器
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/12/android-fuchsia-hello.jpg",
        "https://fuchsia-china.com/aosp-fuchsia-sdk-device/");
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/12/fuchsia-bluetooth-unplugfest.jpg",
        "https://fuchsia-china.com/google-brought-fuchsia-demo-to-unplugfest/");
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/12/android_studio_pixelbook_1.jpg",
        "https://fuchsia-china.com/android-emulator-fuchsia-zircon/");
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/11/fuchsia.jpg",
        "https://fuchsia-china.com/the-4-layers-of-fuchsia/");
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/11/fuchsia-hands-on.jpg",
        "https://fuchsia-china.com/hands-on-with-fuchsia-os/");
    addBanner(
        "https://fuchsia-china.com/wp-content/uploads/2018/11/kirin970.jpg",
        "https://fuchsia-china.com/fuchsia-os-adds-support-for-kirin-970/");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initView();
  }

  Widget initView() {
    return Container(
      //double.infinity为撑满父控件
      width: double.infinity,
      height: double.infinity,
      color: Colors.cyanAccent,
      child: new Column(
        children: <Widget>[
          new Stack(
            //偏移量（可为负数）
            alignment: const Alignment(0, 1),
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 230,
                  color: Colors.lightBlueAccent,
                  child: CarouselSlider(
                      items: map<Widget>(listData, (index, i) {
                        return Builder(
                          builder: (BuildContext context) {
                            //页面切换时调用
                            return Container(
                              //宽度撑满
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.amber),
                              child: GestureDetector(
                                child: Image.network(
                                  listData[index].getImage(),
                                  fit: BoxFit.cover,
                                ),
                                onTap: () {
                                  ToastUtil.showMsg("点击了图片" + index.toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return WebViewPage(
                                      listData[index].getUrl(),
                                      object: null,
                                    );
                                  }));
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                      csOnPageChanged: ((int pageIndex) {
                        setState(() {
                          currentIndex = pageIndex;
                        });
                      }),
                      initialPage: currentIndex,
                      height: 230.0,
                      autoPlay: true)),
              Container(
                height: 20.0,
                width: MediaQuery.of(context).size.width,
                //背景颜色
                color: Colors.black45,
                //显示在中间
                alignment: Alignment.center,
//                constraints: BoxConstraints.expand(width: 200, height: 20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _renderIndicatorTag(),
                ),
              ),
            ],
          ),
          //banner下面的布局啊！
          Container(
            //FlatButton(它会跟随Container的尺寸属性适应)
            //设置背景颜色方便观察布局展示原理
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              //RaisedButton、FloatingActionButton、FlatButton、OutlineButton、MaterialButton
              //button自带上下边距（目前无法去掉）
//          （1）RaisedButton
//          Material Design中的button， 一个凸起的材质矩形按钮。
//          （2）FlatButton
//          Material Design中的button，一个没有阴影的材质设计按钮。常用的比如一些界面上面的文字区域点击可以使用它，还有水波纹效果。
//          dialog有确定和取消两个选项，5.0以上的手机，触摸或者点击这两个选项是有水波纹一样的效果，我们可以用FlatButton。
//          toolbar上面显示的文本触摸或者点击也有这样的效果，我们也都可以通过FlatButton实现。
//          （3）RawMaterialButton:
//          Material Design中的button，RaisedButton和FlatButton之间的交叉：一个带边框的背景透明的按钮，当按下按钮时，其高度增加，背景变得不透明。
//          RaisedButton 和 FlatButton 基于当前Theme和ButtonThem配置一个RawMaterialButton。
//          Flatbutton最普通，RaisedButton还能配置ButtonTheme，是Flatbutton的一个升级版本，RawMaterialButton是他们两个的升级版本。
              onPressed: () {
                //点击事件回调
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return BoxTestPage();
                }));
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('测试弹框'),
              //按钮的背景颜色
              color: Colors.white,
              //文字的颜色
              textColor: Colors.red,
              //按钮的主题
              textTheme: ButtonTextTheme.normal,
              onHighlightChanged: (bool b) {
                //水波纹高亮变化回调
              },
              //按钮禁用时候文字的颜色
              disabledTextColor: Colors.black54,
              //按钮被禁用的时候显示的颜色
              disabledColor: Colors.black54,
              //点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
              highlightColor: Colors.lightBlueAccent,
              //水波纹的颜色
              splashColor: Colors.white,
              //按钮主题高亮
              colorBrightness: Brightness.light,
              //按钮下面的阴影
              elevation: 10.0,
              //高亮时候的阴影
              highlightElevation: 10.0,
              //按下的时候的阴影
              disabledElevation: 10.0,
//              shape:,//设置形状  LearnMaterial中有详解
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                if (Platform.isIOS) {
                  //ios相关代码
                  ToastUtil.showMsg("这是ios设备");
                } else if (Platform.isAndroid) {
                  //android相关代码
                  ToastUtil.showMsg("这是android设备");
                }
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('这是什么设备？？？'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return APage();
                }));
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('测试页面跳转'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                turnOnTheLight();
              },
              //RaisedButton无法设置大小所以可以用控件把它撑大=》但是不能设置外边距
              child: Text('开始闪烁'),
            ),
          ),

        ],
      ),
    );
  }

  //banner下面的圆点指示器
  List<Widget> _renderIndicatorTag() {
    List<Widget> indicators = [];
    final int len = listData.length;

    for (var index = 0; index < len; index++) {
      indicators.add(index == currentIndex
          ? IndicatorUtil.generateIndicatorItem(normal: false)
          : IndicatorUtil.generateIndicatorItem(normal: true));
      if (index != len - 1) {
        indicators.add(SizedBox(
          width: 10,
        ));
      }
    }

    return indicators;
  }

  //banner添加数据
  addBanner(String image, String url) {
    HomeBanner homeBanner = HomeBanner();
    homeBanner.setImage(image);
    homeBanner.setUrl(url);
    listData.add(homeBanner);
  }

  turnOnTheLight() {
    NetConnection.getInstance().post(
      Constant.TEST_TURN_ON_THE_LIGHT,
      (data) {
        setState(() {
          ToastUtil.showMsg("请求成功");
        });
      },
      errorCallBack: (Function errorCallBack, String error) {},
    );
  }
}
