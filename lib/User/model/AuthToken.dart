import 'package:dooromi/User/model/DetailUser.dart';

class AuthToken {
  static var token ;
  static DetailUser user = new DetailUser("", "", "", "", "");

  getToken(){
    return token;
  }

  static getUser(){
    print(user.email);
     return user;
  }
}