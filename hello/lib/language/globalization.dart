import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
/**
 * 国际化多语言测试
 */

MyLocalizations getMyLocalizations(BuildContext context){

  return MyLocalizations.of(context);
}

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }
/////////////////////////////////////////////////////////////////
  /**
   * 注意每次添加一个词语app需要重新运行一次，就是这么坑
   */
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My App',
      'home': 'Home',
      'home_title': 'My Demo',
      'hello_world':'Hello world',
    },
    'zh': {
      'title': 'Hello的app',
      'home': '首页',
      'home_title': 'Hello的Demo',
      'hello_world':'你好世界',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
  String get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  String get home_title {
    return _localizedValues[locale.languageCode]['home_title'];
  }

  String get hello_world {
    return _localizedValues[locale.languageCode]['hello_world'];
  }

/////////////////////////////////////////////////////////////////
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    //异步加载这里返回SynchronousFuture
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
