import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello/utils/cache_utils.dart';
import 'package:hello/utils/constant.dart';
import 'package:hello/utils/toast_util.dart';
import 'package:image_picker/image_picker.dart';

class ReleaseDynamicsPage extends StatefulWidget {
  final String id;
  final Object object;

  ReleaseDynamicsPage(
    this.id, {
    @required this.object,
  });

  @override
  State<StatefulWidget> createState() {
    return _ReleaseDynamicsPageState();
  }
}

class _ReleaseDynamicsPageState extends State<ReleaseDynamicsPage> {
  TextEditingController _controller = TextEditingController();
  List<File> fileList = List();
  Future<File> _imageFile;
  bool isLoading = false;
  String msg = "";

  Widget getBody() {
    // 输入框
    var textField = TextField(
      decoration: InputDecoration(
          hintText: "说点什么吧～",
          hintStyle: TextStyle(color: const Color(0xFF808080)),
          border: OutlineInputBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(10.0)))),
      maxLines: 6,
      maxLength: 150,
      controller: _controller,
    );
    // gridView用来显示选择的图片
    var gridView = Builder(
      builder: (ctx) {
        return GridView.count(
          // 分4列显示
          crossAxisCount: 4,
          children: List.generate(fileList.length + 1, (index) {
            // 这个方法体用于生成GridView中的一个item
            var content;
            if (index == 0) {
              // 添加图片按钮
              var addCell = Center(
                  child: Image.asset(
                './images/icon.png',
                width: 80.0,
                height: 80.0,
              ));
              content = GestureDetector(
                onTap: () {
                  // 添加图片
                  pickImage(ctx);
                },
                child: addCell,
              );
            } else {
              // 被选中的图片
              content = Center(
                  child: Image.file(
                fileList[index - 1],
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ));
            }
            return Container(
              margin: const EdgeInsets.all(2.0),
              width: 80.0,
              height: 80.0,
              color: const Color(0xFFECECEC),
              child: content,
            );
          }),
        );
      },
    );
    var children = [
      textField,
      Container(
          margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          height: 200.0,
          child: gridView)
    ];
    if (isLoading) {
      children.add(Container(
        margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } else {
      children.add(Container(
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Center(
            child: Text(msg),
          )));
    }
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: children,
      ),
    );
  }

  // 相机拍照或者从图库选择图片
  pickImage(ctx) {
    // 如果已添加了9张图片，则提示不允许添加更多
    num size = fileList.length;
    if (size >= 9) {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text("最多只能添加9张图片！"),
      ));
      return;
    }
    showModalBottomSheet<void>(context: context, builder: _bottomSheetBuilder);
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    return Container(
        height: 182.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            children: <Widget>[
              _renderBottomMenuItem("相机拍照", ImageSource.camera),
              Divider(
                height: 2.0,
              ),
              _renderBottomMenuItem("图库选择照片", ImageSource.gallery)
            ],
          ),
        ));
  }

  _renderBottomMenuItem(title, ImageSource source) {
    var item = Container(
      height: 60.0,
      child: Center(child: Text(title)),
    );
    return InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          _imageFile = ImagePicker.pickImage(source: source);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布动态", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Builder(
            builder: (ctx) {
              return IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    //因为缓存和读取都用了异步暂时怀疑有时效问题
                    CacheUtils.getString(Constant.LOGIN_TOKEN).then((onValue) {
                      if (onValue.isNotEmpty) {
                      } else {
                        ToastUtil.showMsg("冇登陆");
                      }
                    });
                  });
            },
          )
        ],
      ),
      // 在这里接收选择的图片
      body: FutureBuilder(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null &&
              _imageFile != null) {
            // 选择了图片（拍照或图库选择），添加到List中
            fileList.add(snapshot.data);
            _imageFile = null;
          }
          // 返回的widget
          return getBody();
        },
      ),
    );
  }
}
