import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hello/language/globalization.dart';
import 'package:hello/page/splash_page.dart';
import 'base/page/base_stateless_widget.dart';

void main() => runApp(MyApp());

class MyApp extends BaseStatelessWidget {
  // 应用入口
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],

//      //去掉debug标签（debug模式会开启大量检查工具影响运行速度，正式包会自动关闭检查工具）
//      debugShowCheckedModeBanner: false,
      //应用的标题，打开应用时显示在app上方
      title: "My App",
      theme: ThemeData(
        //主题数据
        primaryColor: Colors.blue,
      ),
      //设置Stateful//控件基础框架（中文名：脚手架）
      home: SplashPage(),
    );
  }
}
