List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

bool isEmpty(String str) {
  if (str == null || str.isEmpty) {
    return true;
  } else {
    return false;
  }
}

bool isTrue(bool b) {
  return b != null && b != false;
}
///实现一个手机号中间替换****（国际版）
String delAccount(String account) {
  var newAccount = "";
  int len = account.length;
  if (len > 5) {
    int start = (len - 4) ~/ 2;
    if (len % 2 == 0) {
      newAccount = account.replaceRange(start, start + 4, "****");
    } else {
      newAccount = account.replaceRange(start + 1, start + 5, "****");
    }
    return newAccount;
  }
  return account;
}
