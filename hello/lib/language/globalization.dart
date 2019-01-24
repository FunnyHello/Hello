import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
/**
 * 国际化多语言测试
 */

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My App',
      'home_title': 'My Demo',
    },
    'zh': {
      'title': 'Hello的app',
      'home_title': 'Hello的Demo',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get home_title {
    return _localizedValues[locale.languageCode]['home_title'];
  }
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
