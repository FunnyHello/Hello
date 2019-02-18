import 'package:dio/dio.dart';

class NetConnection {
  static final String GET = "get";
  static final String POST = "post";
  static final String SERVER = "http://10.10.10.229:8080/";

  Dio dio;
  static NetConnection _instance;

  static NetConnection getInstance() {
    if (_instance == null) {
      _instance = NetConnection();
    }
    return _instance;
  }

  NetConnection() {
    dio = Dio(Options(
      //添加Header参数
      headers: {'platform': 'android', 'version': 1.0},
      connectTimeout: 15000,
      receiveTimeout: 100000,
    ));
  }

  //get请求
  get(String url, Function successCallBack,
      {Function errorCallBack, formData}) async {
    _requstHttp(url, GET, successCallBack, errorCallBack, formData: formData);
  }

  //post请求
  post(String url, Function successCallBack,
      {Function errorCallBack, formData}) async {
    _requstHttp(url, POST, successCallBack, errorCallBack, formData: formData);
  }

  _requstHttp(String url, String method, Function successCallBack,
      Function errorCallBack,
      {FormData formData}) async {
    try {
      //拼接服务器地址
      url = SERVER + url;
      Response response;
      _addStartHttpInterceptor(dio); //添加请求之前的拦截器
      print("+++++++++++请求参数：" + formData.toString());
      if (method == GET) {
        if (formData != null && formData.isNotEmpty) {
          response = await dio.get(url, data: formData);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (formData != null && formData.isNotEmpty) {
          response = await dio.post(url, data: formData);
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
    dio.interceptor.request.onSend = (Options options) {
      //请求前处理
      Map<String, dynamic> headers = options.headers;
      Map<String, dynamic> body = options.data;
      return options;
    };
  }
}
