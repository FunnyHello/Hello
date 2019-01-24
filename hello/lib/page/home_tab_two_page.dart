import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/bean/movie.dart';
import 'package:hello/page/movie_detail_page.dart';
import 'package:hello/utils/constant.dart';

import 'package:hello/view/toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';


class HomeTabTwoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTabTwoPageState();
  }
}

class _HomeTabTwoPageState extends State<HomeTabTwoPage> {
  List<Movie> movies = [];

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<
      EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<
      RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<
      RefreshFooterState>();
  bool isShowPullDown = true;

  @override
  void initState() {
    super.initState();
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

    // TODO: implement build
    return twoContentUi;
  }

  Widget initView() {
    return new EasyRefresh(
      key: _easyRefreshKey,
      refreshHeader: ClassicsHeader(
        key: _headerKey,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
      ),
      child: new ListView(
        children: buildMovieItems(),
      ),
      onRefresh: () async {
        Toast.toast(context, "下拉");
      },
      loadMore: () async {
        Toast.toast(context, "上拉");
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

      var movieMsg = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            movie.title,
            textAlign: TextAlign.left,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          new Text('导演：' + movie.director),
          new Text('主演：' + movie.cast),
          new Text('评分：' + movie.average),
          new Text(
            movie.collectCount.toString() + '人看过',
            style: new TextStyle(
              fontSize: 12.0,
              color: Colors.redAccent,
            ),
          ),
        ],
      );

      var movieItem = new GestureDetector(
        //点击事件
        //onTap: () => navigateToMovieDetailPage(movie, i),
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return new MovieDetailPage(movie, imageTag: i);
          }));
        },
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                movieImage,
                //Expanded 均分
                new Expanded(
                  child: movieMsg,
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            new Divider(),
          ],
        ),
      );

      widgets.add(movieItem);
    }
    return widgets;
  }

  //网络请求
  getMovieListData() async {
    //请求成功，但是解析数据失败，暂时不知道什么原因
//    Dio dio = new Dio();
//    Response response = await dio.post(Constant.DOUBAN_MOVIE);
//    setState(() {
//        movies.addAll(Movie.decodeData(response.data.toString()));
//      });

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(Constant.DOUBAN_MOVIE));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();
      // setState 相当于 runOnUiThread
      setState(() {
        movies.addAll(Movie.decodeData(jsonData.toString()));
      });
    }
  }
}
