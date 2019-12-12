import 'package:dio/dio.dart';

import '../constant.dart';

class NetConnection {
  static final String GET = "get";
  static final String POST = "post";

  Dio dio;
  static NetConnection _instance;

  static NetConnection getInstance() {
    if (_instance == null) {
      _instance = NetConnection();
    }
    return _instance;
  }

  NetConnection() {
    dio = Dio(BaseOptions (
      //添加Header参数
      headers: {'platform': 'android', 'version': 1.0},
      connectTimeout: 15000,
      receiveTimeout: 100000,
    ));
  }

  //get请求
  get(String url, Function successCallBack,
      {Function errorCallBack, param}) async {
    _requstHttp(url, GET, successCallBack, errorCallBack, param: param);
  }

  //post请求
  post(String url, Function successCallBack,
      {Function errorCallBack, param}) async {
    _requstHttp(url, POST, successCallBack, errorCallBack, param: param);
  }

  _requstHttp(String url, String method, Function successCallBack,
      Function errorCallBack, {param}) async {
    try {
      //拼接服务器地址
//      url = SERVER + url;
      Response response;
      _addStartHttpInterceptor(dio); //添加请求之前的拦截器
      print("+++++++++++请求参数：" + param.toString());
      if (method == GET) {
        if (param != null) {
          response = await dio.get(url, queryParameters: param);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (param != null) {
          response = await dio.post(url, data: param);
        } else {
          response = await dio.post(url);
        }
      }
      if (successCallBack != null) {
        print("+++++++++++返回参数：" + response.data.toString());
        successCallBack(response.data.toString());
      } else {
        _error(errorCallBack, "");
      }
    } catch (exception) {
      _error(errorCallBack, exception.toString());
    }
  }

  _error(Function errorCallBack, String error) {
    print("+++++++++++返回失败");
    if (errorCallBack != null) {
      errorCallBack(errorCallBack, error);
    }
  }

  _addStartHttpInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          //请求前搞点啥子
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) async {
          // Do something with response data
          return response; // continue
        },
        onError: (DioError e) async {
          // Do something with response error
          return  e;//continue
        }
    ));
  }
}
