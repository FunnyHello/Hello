//library carousel_slider;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/**
 * 无限滚动的pageView
 * 来自https://github.com/serenader2014/flutter_carousel_slider
 */
int _remander(int input, int source) {
  final int result = input % source;
  return result < 0 ? source + result : result;
}

int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _remander(offset, length);
}

class CarouselSlider extends StatefulWidget {
  final List<Widget> items;
  final num viewportFraction;
  final num initialPage;
  final double aspectRatio;
  final double height;
  final PageController pageController;
  final num realPage;

  //是否自动播放
  final bool autoPlay;

  //自动播放时间
  final Duration autoPlayDuration;
  final Curve autoPlayCurve;

  //间隔
  final Duration interval;
  final bool reverse;
  final Function updateCallback;
  final ValueChanged<int> csOnPageChanged;

  CarouselSlider(
      {@required this.items,
      this.viewportFraction: 0.8,
      this.initialPage: 0,
      //高宽比
      this.aspectRatio: 16 / 9,
      this.height,
      this.realPage: 10000,
      this.autoPlay: false,
      this.interval: const Duration(seconds: 4),
      this.reverse: false,
      this.autoPlayCurve: Curves.fastOutSlowIn,
      this.autoPlayDuration: const Duration(milliseconds: 800),
      this.updateCallback,
      this.csOnPageChanged})
      : pageController = new PageController(
          viewportFraction: viewportFraction,
          initialPage: realPage + initialPage,
        );

  @override
  _CarouselSliderState createState() {
    return new _CarouselSliderState();
  }

  Future<Null> nextPage({Duration duration, Curve curve}) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  Future<Null> previousPage({Duration duration, Curve curve}) {
    return pageController.previousPage(duration: duration, curve: curve);
  }

  jumpToPage(int page) {
    final index =
        _getRealIndex(pageController.page.toInt(), realPage, items.length);
    return pageController
        .jumpToPage(pageController.page.toInt() + page - index);
  }

  animateToPage(int page, {Duration duration, Curve curve}) {
    final index =
        _getRealIndex(pageController.page.toInt(), realPage, items.length);
    return pageController.animateToPage(
        pageController.page.toInt() + page - index,
        duration: duration,
        curve: curve);
  }
}

class _CarouselSliderState extends State<CarouselSlider>
    with TickerProviderStateMixin {
  int currentPage;
  Timer timer;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
    if (widget.autoPlay) {
      timer = new Timer.periodic(widget.interval, (_) {
        widget.pageController.nextPage(
            duration: widget.autoPlayDuration, curve: widget.autoPlayCurve);
      });
    }
  }

  getWrapper(Widget child) {
    if (widget.height != null) {
      return new Container(height: widget.height, child: child);
    } else {
      return new AspectRatio(aspectRatio: widget.aspectRatio, child: child);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return getWrapper(new PageView.builder(
      onPageChanged: (int index) {
        if (widget.csOnPageChanged != null) {
          widget.csOnPageChanged(_getRealIndex(index, widget.realPage, widget.items.length));
        }

        currentPage =
            _getRealIndex(index, widget.realPage, widget.items.length);
        if (widget.updateCallback != null) widget.updateCallback(currentPage);
      },
      controller: widget.pageController,
      reverse: widget.reverse,
      itemBuilder: (BuildContext context, int i) {
        final int index =
            _getRealIndex(i, widget.realPage, widget.items.length);
        return new AnimatedBuilder(
            animation: widget.pageController,
            builder: (BuildContext context, child) {
              // 第一个渲染时，pageController.page为null，
              if (widget.pageController.position.minScrollExtent == null ||
                  widget.pageController.position.maxScrollExtent == null) {
                new Future.delayed(new Duration(microseconds: 1), () {
                  setState(() {});
                });
                return new Container();
              }
              double value = widget.pageController.page - i;
//              //屏外不缩放
//              value = 1.0;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              final double height = widget.height ??
                  MediaQuery.of(context).size.width * (1 / widget.aspectRatio);

              return new Center(
                  child: new SizedBox(
                      height: Curves.easeOut.transform(value) * height,
                      child: child));
            },
            child: widget.items[index]);

      },
    ));
  }
}
