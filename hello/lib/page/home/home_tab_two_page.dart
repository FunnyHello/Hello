import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/bean/movie.dart';
import 'package:hello/page/test/movie_detail_page.dart';
import 'package:hello/utils/constant.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';
import 'package:hello/utils/http/net_connection.dart';
import 'package:hello/utils/toast_util.dart';
import 'dart:convert' as convert;

class HomeTabTwoPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTabTwoPageState();
  }
}

/**
 *  设置with AutomaticKeepAliveClientMixin
 *  bool get wantKeepAlive => true;
 *  最后在build中加入super.build(context);
 *  防止tab切换时initState反复执行
 */
class _HomeTabTwoPageState extends BaseState<HomeTabTwoPage> {
  List<Movie> movies = [];
  EasyRefreshController _controller;

  bool isShowPullDown = true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    getMovieListData();
  }

  @override
  Widget build(BuildContext context) {
    var twoContentUi;
    if (movies.isEmpty) {
      twoContentUi = new Center(
        child: new CircularProgressIndicator(), //Material Design风格的循环进度条
      );
    } else {
      twoContentUi = initView();
    }
    return twoContentUi;
  }

  Widget initView() {
    return new EasyRefresh(
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      child: new ListView(
        children: buildMovieItems(),
      ),
      onRefresh: () async {
        showToast("下拉");
      },
      onLoad: () async {
        showToast("上拉");
      },
    );
  }

  buildMovieItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < movies.length; i++) {
      Movie movie = movies[i];
      var movieImage = new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: new Image.network(
          movie.smallImage,
          width: 100.0,
          height: 120.0,
        ),
      );

      var movieMsg = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            movie.title,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          Text('导演：' + movie.director),
          Text('主演：' + movie.cast),
          Text('评分：' + movie.average),
          Text(
            movie.collectCount.toString() + '人看过',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.redAccent,
            ),
          ),
        ],
      );

      var movieItem = GestureDetector(
        //点击事件
        //onTap: () => navigateToMovieDetailPage(movie, i),
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MovieDetailPage(movie, imageTag: i);
          }));
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                movieImage,
                //Expanded 均分
                Expanded(
                  child: movieMsg,
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            Divider(),
          ],
        ),
      );

      widgets.add(movieItem);
    }
    return widgets;
  }

  //网络请求
  getMovieListData() async {
//    /*将字符串转成json  返回的是键值对的形式*/
//    Map<String, dynamic> news = jsonDecode("");
//    /*取值*/
//    String sats = news['result']['stat'];
//    /*将Json转成实体类*/
//    NewsBean newsBean=NewsBean.fromJson(news);
//    /*取值*/
//    String sats = newsBean.result.stat;

//    NetConnection.getInstance().get(
//     DOUBAN_MOVIE,
//      (data) {
//        setState(() {
//          movies.addAll(Movie.decodeData(convert.jsonEncode(data)));
//        });
//      },
//      errorCallBack: (Function errorCallBack, String error) {},
//    );
    //请求成功，但是解析数据失败，暂时不知道什么原因
//    Dio dio = new Dio();
//    Response response = await dio.post(DOUBAN_MOVIE);
//    setState(() {
//        movies.addAll(Movie.decodeData(response.data.toString()));
//      });

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(DOUBAN_MOVIE));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();
      // setState 相当于 runOnUiThread
      setState(() {
        print("++++++++++" + jsonData.toString());
        movies.addAll(Movie.decodeData(jsonData.toString()));
      });
    }
  }
}
