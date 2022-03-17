import 'package:intl/intl.dart';

class DetailUser {
  String username;
  String password;
  String fullname;
  String email;
  String joinedAt;

  DetailUser(
      this.username,
      this.password,
      this.fullname,
      this.email,
      this.joinedAt);

  String get getUserName => username;
  String get getPassword => password;
  String get getFullname => fullname;
  String get getEmail => email;
  String get getJoinedAt => joinedAt;

  Map<String, dynamic> toJson() => {
    "username" : this.username.toString(),
    "password": this.password.toString(),
    "fullname" :  this.fullname.trim(),
    "email" : this.email.trim()
  };

  static DetailUser fromJson(Map<String, dynamic> response) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return new DetailUser(
          response['username'],
          response['password'],
          response['fullname'],
          response['email'],
          dateFormatter.format(DateTime.parse(response['createdAt'])));
  }
}