import 'package:fluttertoast/fluttertoast.dart';


showToast(String str){

}
class ToastUtil {
  static void showMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }
}
