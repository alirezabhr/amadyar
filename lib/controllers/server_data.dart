import 'package:dio/dio.dart';

import 'auth.dart';

class ServerData {
  static String serverBaseAPI = 'http://10.0.2.2:8000';

  final String baseUrl = 'http://10.0.2.2:8000/';
  final Dio _dio = Dio();

  ServerData () {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Dio> getDio () async {
    String? token = await Auth.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = "Token $token";
    }
    return _dio;
  }

}