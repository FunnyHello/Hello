import 'is_uspension_bean.dart';

class CountryCode extends ISuspensionBean {
  /// 国名
  String name;

  ///是否置顶
  String tagIndex;

  ///拼音名
  String namePinyin;

  /// 旗帜
  String flagUri;

  /// 国家代码 (IT,AF..)
  String code;

  /// 区号 (+39,+93..)
  String dialCode;

  CountryCode(
      {this.name,
      this.tagIndex,
      this.namePinyin,
      this.flagUri,
      this.code,
      this.dialCode});

  CountryCode.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'flagUri': flagUri,
    'code': code,
    'dialCode': dialCode,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
