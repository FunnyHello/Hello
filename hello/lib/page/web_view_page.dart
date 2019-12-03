import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String stringUrl;
  final Object object;

  WebViewPage(
    this.stringUrl, {
    @required this.object,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebViewPageState();
  }

}

class _WebViewPageState extends State<WebViewPage> {

  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  var urlString;

  launchUrl() {
    setState(() {
      urlString = controller.text;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }

  @override
  void initState() {
    super.initState();
    urlString = widget.stringUrl;
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });

    //  监听url地址改变事件
    flutterWebviewPlugin.onUrlChanged.listen((String url) {

    });

    //  监听页面滚动事件
    flutterWebviewPlugin.onScrollYChanged.listen((double offsetY) {

    });

    flutterWebviewPlugin.onScrollXChanged.listen((double offsetX) {

    });
//    //隐藏webview
//    flutterWebviewPlugin.launch(urlString, hidden: true);
//    //关闭webview
//    flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          controller: controller,
          textInputAction: TextInputAction.go,
          onSubmitted: (url) => launchUrl(),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: urlString,
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => launchUrl(),
          )
        ],
      ),
      url: urlString,
      withZoom: false, // 允许网页缩放
      withLocalStorage: true, // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }
}
