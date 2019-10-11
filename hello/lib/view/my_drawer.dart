import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello/page/login_page.dart';
import 'package:hello/page/release_dynamics_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:hello/utils/toast_util.dart';

class MyDrawer extends StatelessWidget {
  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;

  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;

  //头像
  var userAvatar;

  //用户名
  var userName;

  // 菜单后面的箭头图片
  var rightArrowIcon = Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  // 菜单的文本
  List menuTitles = ['动态', '扫码', '关于', '设置'];

  // 菜单文本前面的图标
  List menuIcons = [
    './images/icon.png',
    './images/icon.png',
    './images/icon.png',
    './images/icon.png'
  ];

  // 菜单文本的样式
  TextStyle menuStyle = TextStyle(
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: Material(
        elevation: 16.0,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
          ),
          child: Container(
            child: ListView.builder(
              itemCount: menuTitles.length * 2 + 1,
              itemBuilder: renderRow,
            ),
          ),
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
      child: Image.asset(path, width: 28.0, height: 28.0),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // render cover image
      return Stack(
        //偏移量（可为负数）
        alignment: const Alignment(0, 0),
        children: <Widget>[
          //背景
          Container(
            width: 304.0,
            height: 200.0,
            child: Image.asset(
              './images/fuchsia.jpg',
              width: 304.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          //头像
          Container(
            color: Colors.black45,
            width: 304.0,
            height: 200.0,
            child: Center(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userAvatar == null
                        ? Image.asset(
                            "images/icon_avatar_default.png",
                            width: 60.0,
                          )
                        : Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: NetworkImage(userAvatar),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                    Text(
                      userName == null ? "点击头像登录" : userName,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ],
                ),
                onTap: () {
                  ToastUtil.showMsg("假装去登陆");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginPage();
                  }));
                },
              ),
            ),
          ),
        ],
      );
//      return new Container(
//        width: 304.0,
//        height: 200.0,
//        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//        child: img,
//      );
    }
    // 舍去之前的封面图
    index -= 1;
    // 如果是奇数则渲染分割线
    if (index.isOdd) {
      return Divider();
    }
    // 偶数，就除2取整，然后渲染菜单item
    index = index ~/ 2;
    // 菜单item组件
    var listItemContent = Padding(
      // 设置item的外边距
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      // Row组件构成item的一行
      child: Row(
        children: <Widget>[
          // 菜单item的图标
          getIconImage(menuIcons[index]),
          // 菜单item的文本，需要
          Expanded(
              child: Text(
            menuTitles[index],
            style: menuStyle,
          )),
          rightArrowIcon
        ],
      ),
    );

    return InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
            // 动态
            ToastUtil.showMsg("点击了动态");
            //点击后收起侧边栏(要在跳转之前执行)
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ReleaseDynamicsPage(
                "",
                object: null,
              );
            }));

            break;
          case 1:
            // 扫码
            ToastUtil.showMsg("你为什么会扫码?");
            //点击后收起侧边栏
            Navigator.of(context).pop();
            scan(context);
            break;
          case 2:
            // 关于
            ToastUtil.showMsg("点击了关于");
            //点击后收起侧边栏
            Navigator.of(context).pop();
//            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
//              return new AboutPage();
//            }));
            break;
          case 3:
            // 设置
            ToastUtil.showMsg("点击了设置");
            //点击后收起侧边栏
            Navigator.of(context).pop();
//            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
//              return new SettingsPage();
//            }));
            break;
        }
      },
    );
  }

  Future scan(BuildContext context) async {
    try {
      String barcode = await BarcodeScanner.scan();
      ToastUtil.showMsg("扫了" + barcode);
      print(barcode);
    } on Exception catch (e) {
      print(e);
    }
  }
}
