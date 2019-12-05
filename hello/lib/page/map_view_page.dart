
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello/base/page/base_state.dart';
import 'package:hello/base/page/base_stateful_widget.dart';

class MapViewPage extends BaseStatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapViewPageState();
  }
}

class _MapViewPageState extends BaseState<MapViewPage> {
  @override
  Widget build(BuildContext context) {

    return initView();
  }

  Widget initView() {
    return FlutterMap(
      options: new MapOptions(
//        center: new LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
//              point: new LatLng(51.5, -0.09),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}