import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/bean/home_banner.dart';
import 'package:hello/page/test/a_page.dart';
import 'package:hello/page/test/box_test_page.dart';
import 'package:hello/page/test/choice_chip_page.dart';
import 'package:hello/page/test/password_input_page.dart';
import 'package:hello/page/test/sideslip_item_page.dart';
import 'package:hello/page/test/skidding_deletion_page.dart';
import 'package:hello/page/test/verification_code_page.dart';
import 'package:hello/page/test/video_player_page.dart';
import 'package:hello/page/test/web_view_page.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:hello/utils/type_utils.dart';
import 'package:hello/view/banner/carousel_slider.dart';
import 'package:hello/view/banner/indicator_util.dart';
import 'package:hello/view/country/country_code.dart';

import '../country/country_code_page.dart';
import '../test/map_view_page.dart';

class HomeTabOnePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabOnePageState();
  }
}

class _HomeTabOnePageState extends BaseState<HomeTabOnePage> {
  //banner数据
  List<HomeBanner> listData = <HomeBanner>[];

  //当前指示器
  int currentIndex = 0;
  //SafeArea用于兼容刘海屏和iPhone X类似的底部bottom的区域

  StreamSubscription _subscription = null;

  static const counterPlugin = const EventChannel('com.example.hello');
  @override
  void initState() {
    super.initState();
    //开启监听
    if(_subscription == null){
      _subscription =  counterPlugin.receiveBroadcastStream().listen(_onEvent,onError: _onError);
    }


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

  void _onEvent(Object event) {
    setState(() {
      showToast("activity界面的参数："+ event);
    });
  }

  void _onError(Object error) {
    setState(() {
      showToast("滑稽");
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消监听
    if(_subscription != null){
      _subscription.cancel();
    }
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
      child: ListView(
        children: <Widget>[
          Stack(
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
            color: Colors.blue,
            margin:const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
              child: Text('树莓派小灯闪烁'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return MapViewPage();
                }));
              },
              child: Text('演示地图'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return VideoPlayerPage();
                }));
              },
              child: Text('视频演示'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
//                Navigator.of(context)
//                    .push(MaterialPageRoute(builder: (BuildContext context) {
//                  return CountryCodePage();
//                }));
                toCountryPage();
              },
              child: Text('字母分类效果演示'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ChoiceChipPage();
                }));
              },
              child: Text('标签选择控件与选择按钮演示'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SkiddingDeletionPage();
                }));
              },
              child: Text('侧滑删除'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SideslipItemPage();
                }));
              },
              child: Text('侧滑Item'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return PasswordInputPage();
                }));
              },
              child: Text('支付宝密码输入控件'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return VerificationCodePage();
                }));
              },
              child: Text('验证码输入控件'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: RaisedButton(
              onPressed: () {
                startActivity();
              },
              child: Text('与原生沟通'),
            ),
          ),
        ],
      ),
    );
  }

  static const platform = const MethodChannel('com.example.hello');
  Future<bool> startActivity() async {
    String result;
    try {
      result = await platform.invokeMethod("startActivity", {
        "flutter": "Flutter传入的参数",
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
    showToast(result.toString());
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
      SERVER + TEST_TURN_ON_THE_LIGHT,
      (data) {
        setState(() {
          ToastUtil.showMsg("请求成功");
        });
      },
      errorCallBack: (Function errorCallBack, String error) {},
    );
  }

  void toCountryPage() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CountryCodePage();
    }));

    if (result != null) {
      CountryCode countryCode = result as CountryCode;

      /*弹窗显示返回的数据*/
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("返回的结果"),
              content: Text(
                  "${countryCode.name},${countryCode.code},${countryCode.dialCode}"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定"))
              ],
            );
          });
    }
  }
}
