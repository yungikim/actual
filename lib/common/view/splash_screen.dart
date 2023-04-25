import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //sfl로 설정해야 initState를 사용할 수 있다.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // deleteToken();
    //initSate에서 await를 사용할 수 없어 별도 일반 함수를 생성한다.
    checkToken();
  }

  void deleteToken() async {
    storage.deleteAll();
  }

  checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try{
      final resp = await dio.post('http://$ip/auth/token',
          options: Options(headers: {
            'authorization': 'Bearer $refreshToken',
          }));

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      //pushAndRemoveUntil을 하면 뒤로가기를 제거해 준다.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RootTab(),
        ),
            (route) => false,
      );
    }catch(e){
      print(e);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (route) => false,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/img/logo/logo.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
