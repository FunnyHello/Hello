import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello/page/home_page.dart';
import 'package:hello/page/login_page.dart';
import 'package:hello/utils/cache_utils.dart';
import 'package:hello/utils/constant.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    CacheUtils.getString(Constant.LOGIN_TOKEN).then((onValue) {
      if (onValue.isNotEmpty) {
        //延迟三秒执行
        Timer timer = Timer(Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return HomePage();
            },
          ), (route) => route == null);
        });
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ), (route) => route == null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initView(),
    );
  }

  Widget initView() {
    return Image.asset(
      'images/icon_splash.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
//    return Image.network(
//      Constant.APLASH_IMAGE_URL,
//      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height,
//      fit: BoxFit.cover,
//    );
  }
}
