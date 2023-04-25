import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//아이디와 패스워드 같이 데이터를 암호화해서 저장해야하는 부분은 FlutterSecureStorage를 사용한다.
//이걸 사용하려면 android >> app >> build.grade 안에 minSdkVersion : 18로 변경 해야 한다.
final storage = FlutterSecureStorage();

//localhost
//final emulatorIp = "10.0.2.2:3000";
final emulatorIp = "files.kmslab.com:13001";
//final simulatorIp = "127.0.0.1:3000";
final simulatorIp = "files.kmslab.com:13001";

final ip = Platform.isIOS ? simulatorIp : emulatorIp;