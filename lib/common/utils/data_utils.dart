import '../const/data.dart';

class DataUtils{
  //무조건 static이여야 한다.
  static pathToUrl(String value){
    //return 'http://$ip$value';
    return '$value';
  }

  static pathToUrl2(String value){
    return 'http://$ip$value';
  }
}