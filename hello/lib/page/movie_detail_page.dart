import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/bean/movie.dart';
import 'package:hello/bean/movie_detail.dart';
import 'package:hello/utils/constant.dart';
import 'package:meta/meta.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final Object imageTag;

  MovieDetailPage(
      this.movie, {
        @required this.imageTag,
      });

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPageState();
  }

}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail movieDetail;

  @override
  void initState() {
    super.initState();
    getMovieDetailData();
  }

  getMovieDetailData() async {
    var httpClient =  HttpClient();
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
      content =  Center(
        child:  CircularProgressIndicator(),
      );
    } else {
      content = setData(movieDetail);
       Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child:  Scrollbar(
          child: content,
        ),
      );
    }

    return  Scaffold(
      appBar:  AppBar(
        //注意这里的写法 widget.movie，拿到 MovieDetailPage
        title:  Text(widget.movie.title),
      ),
      body: content,
    );
  }

  setData(MovieDetail movieDetail) {
    var movieImage =  Hero(
      tag: widget.imageTag,
      child:  Center(
        child:  Image.network(
          movieDetail.smallImage,
          width: 120.0,
          height: 140.0,
        ),
      ),
    );

    var movieMsg =  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         Text(
          movieDetail.title,
          textAlign: TextAlign.left,
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
         Text('导演：' + movieDetail.director),
         Text('主演：' + movieDetail.cast),
         Text(
          movieDetail.collectCount.toString() + '人看过',
          style:  TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
          ),
        ),
         Text('评分：' + movieDetail.average.toString()),
         Text(
          '剧情简介：' + movieDetail.summary,
          style:  TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );
    return  Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child:  Scrollbar(
        child:  Column(
          children: <Widget>[
            movieImage,
            movieMsg,
          ],
        ),
      ),
    );
  }
}