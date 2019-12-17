import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hello/page/splash_page.dart';
import 'base/page/base_stateless_widget.dart';
import 'language/globalization.dart';

void main() => runApp(MyApp());

class MyApp extends BaseStatelessWidget {
  // 应用入口
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///国际化初始化
      localizationsDelegates: [
        //此处
        const MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],

      ///

//      //去掉debug标签（debug模式会开启大量检查工具影响运行速度，正式包会自动关闭检查工具）
//      debugShowCheckedModeBanner: false,
      //应用的标题，打开应用时显示在app上方
      title: "My APP",
      theme: _blackTheme(),
      //设置Stateful//控件基础框架（中文名：脚手架）
      home: SplashPage(),
    );
  }

  ///当字体不设置颜色时，切换主题字体会自适应主题
  ThemeData _blackTheme() {
    final ThemeData base = new ThemeData.fallback();
    return base.copyWith(
      //主题基本颜色，AppBar背景颜色
      primaryColor: Colors.blue,
      //改了也没啥效果（未发现变化）
//      buttonColor: Colors.blue,
//      //指示器颜色（未发现变化）
//      indicatorColor: Colors.white,
//      //强调文字颜色（未发现变化）
//      accentColor: const Color(0xFF13B9FD),
//      //画布颜色，改了bottomNavigationBar背景颜色变化
//      canvasColor: Colors.black,
//      //Scaffold背景颜色
//      scaffoldBackgroundColor: Colors.black,
//      //背景色（未发现变化）
//      backgroundColor: Colors.black,
//      //错误颜色（未发现变化）
//      errorColor:  Colors.red,
//      //button主题
//      buttonTheme: const ButtonThemeData(
//        //button颜色主题
//        textTheme: ButtonTextTheme.primary,
//      ),
//      //文字主题
//      textTheme: base.textTheme,
//      //
//      primaryTextTheme: base.primaryTextTheme,
//      accentTextTheme: base.accentTextTheme,
    );
  }
}
