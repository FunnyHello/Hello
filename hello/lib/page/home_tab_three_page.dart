import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeTabThreePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTabThreePageState();
  }
}

class _HomeTabThreePageState extends BaseState<HomeTabThreePage> {
  String phone = "18577744694";
  String showPhone;

  //选中后的图片
  File imageFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      if (phone.length == 11) {
        showPhone = phone.substring(0, 4) + "****" + phone.substring(8, 11);
      }
    });

    return initView();
  }

  Widget initView() {
    return Container(
      child: ListView(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 64,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showModalBottomSheet<void>(
                  context: context, builder: _bottomSheetBuilder);
            },
            child: Row(
              children: <Widget>[
                //把图片裁成形
                ClipOval(child: headPortrait()),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            '滑稽666',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF101010),
                            ),
                          ),
                        ),
                        Text(
                          showPhone,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF514F4F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Colors.blue,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的包裹',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的优惠券',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的地址',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的账单',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的收藏',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '帮助',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/icon.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '设置',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color(0xFFDFDDDD),
//          color: Co
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '我的客服',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              ToastUtil.showMsg("退换&售后");
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '退换&售后',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              ToastUtil.showMsg("发起电商退件");
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '发起电商退件',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              //子控件对齐方式
              alignment: Alignment.topCenter,
              child: QrImage(
//          backgroundColor: Colors.yellow,
                data: "这是个二维码",
                version: QrVersions.auto,
                size: 200,
                gapless: false,
              ),
            ),
            onTap: () {
              ToastUtil.showMsg("这是个二维码");
            },
          ),
        )
      ]),
    );
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    return Container(
        height: 182.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Text("相机拍照"),
                  ),
                ),
                onTap: () {
                  toSelectPictures(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.translucent,
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Text("图库选择照片"),
                  ),
                ),
                onTap: () {
                  toSelectPictures(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ],
          ),
        ));
  }

  toSelectPictures(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      imageFile = image;
    });
  }

  Widget headPortrait() {
    if (imageFile == null) {
      return Image.asset(
        'images/icon.png',
        width: 42.0,
        height: 42.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        imageFile,
        width: 42.0,
        height: 42.0,
        fit: BoxFit.cover,
      );
    }
  }
}
