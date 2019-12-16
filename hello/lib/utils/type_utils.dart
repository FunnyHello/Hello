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
