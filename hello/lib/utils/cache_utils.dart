import 'package:hello/utils/text_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * IOS使用需要升级pod version
 * https://blog.csdn.net/yaoliangjun306/article/details/77824136
 */
class CacheUtils {
  //缓存
  static setString(String key, String data) async {
    if (!TextUtils.isEmpty(data)) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(key, data);
    }
  }

  // 清除
  static removeString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(key); //删除指定键
  }

  // 获取
  static Future<String> getString(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String str = sp.getString(key);
    return TextUtils.isEmpty(str) ? "" : str;
  }

  // 清除
  static clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear(); //清空键值对
  }
}
