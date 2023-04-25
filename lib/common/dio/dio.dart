import 'dart:io';
import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor{
  //요청 보낼때
  //응답을 받을때
  // 에러가 났을때
  // dio를 생성하고 dio.interceptors.add(CustomInterceptor())를 추가해 주면
  // 이 클래스에 들어온다.

  final FlutterSecureStorage storage;
  CustomInterceptor({
    required this.storage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    // TODO: implement onRequest
    print('[REQ] [${options.method}] ${options.uri}');
    if (options.headers['accessToken'] == 'true'){
      options.headers.remove("accessToken");

      final token = await storage.read(key:ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true'){
      options.headers.remove("refreshToken");

      final token = await storage.read(key:REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    //정상적인 응답이 있는 경우만 호출되는 부분이라 별다른것 없다.
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async{
    // TODO: implement onError
    // 토큰에 문제가 있을때 401에러가 발생 (status code) 여기 서버는 이렇게 설계해 놓음
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null){
      //에러를 그대로 전송한다.
      //refreshToken자체가 없을 경우
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token"; //토큰을 리프레쉬 할려다 에러가 발생함 refreshToken이 문제가 있다.
    if (isStatus401 && !isPathRefresh){
      final dio = Dio();

      try{
        final resp = await dio.post(
            'http://$ip/auth/token',
            options: Options(
                headers: {
                  'authorization': 'Bearer $refreshToken'
                }
            )
        );
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        //토큰 변경하기
        options.headers.addAll({
          'authrization': 'Bearer $accessToken'
        });

        //나중에 사용하기 위해서 값을 변환해 준다.
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //에러가 발생한 원래 가야할 URL을 그대로 호출해 준다. 토큰만 변경하고
        final response = await dio.fetch(options);
        return handler.resolve(response);

      }on DioError catch(e){
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }

}