import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:hello/bean/movie.dart';
import 'package:hello/bean/movie_detail.dart';
import 'package:hello/utils/constant.dart';
import 'package:meta/meta.dart';

class MovieDetailPage extends BaseStatefulWidget {
  final Movie movie;
  final Object imageTag;

  MovieDetailPage(
      this.movie, {
        @required this.imageTag,
      });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieDetailPageState();
  }

}

class _MovieDetailPageState extends BaseState<MovieDetailPage> {
  MovieDetail movieDetail;

  @override
  void initState() {
    super.initState();
    getMovieDetailData();
  }

  getMovieDetailData() async {
    var httpClient = new HttpClient();
    var url = Constant.MOVIE_SUBJECT + widget.movie.movieId;
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();
      // setState 相当于 runOnUiThread
      setState(() {
        movieDetail = MovieDetail.decodeData(jsonData.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (movieDetail == null) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = setData(movieDetail);
      new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: new Scrollbar(
          child: content,
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        //注意这里的写法 widget.movie，拿到 MovieDetailPage
        title: new Text(widget.movie.title),
      ),
      body: content,
    );
  }

  setData(MovieDetail movieDetail) {
    var movieImage = new Hero(
      tag: widget.imageTag,
      child: new Center(
        child: new Image.network(
          movieDetail.smallImage,
          width: 120.0,
          height: 140.0,
        ),
      ),
    );

    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(
          movieDetail.title,
          textAlign: TextAlign.left,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        new Text('导演：' + movieDetail.director),
        new Text('主演：' + movieDetail.cast),
        new Text(
          movieDetail.collectCount.toString() + '人看过',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
          ),
        ),
        new Text('评分：' + movieDetail.average.toString()),
        new Text(
          '剧情简介：' + movieDetail.summary,
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );
    return new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: new Scrollbar(
        child: new Column(
          children: <Widget>[
            movieImage,
            movieMsg,
          ],
        ),
      ),
    );
  }
}