import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoPlayerPageState();
  }
}

class _VideoPlayerPageState extends BaseState<VideoPlayerPage> {
  //多媒体对象
  VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return initView();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.runoob.com/try/demo_source/mov_bbb.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
//    //停止播放
//    _controller.pause();
//    //开始播放
//    _controller.play();
  }

  Widget initView() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(children: <Widget>[
        Center(
          child: _controller.value.initialized
              // 加载成功
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              //加载中
              : Container(
                  child: Text("加载中"),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "播放or暂停",
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF101010),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ]),
//      child: Center(
//        child: _controller.value.initialized
//            // 加载成功
//            ? AspectRatio(
//                aspectRatio: _controller.value.aspectRatio,
//                child: VideoPlayer(_controller),
//              )
//            //加载中
//            : Container(
//                child: Text("加载中"),
//              ),
//      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
