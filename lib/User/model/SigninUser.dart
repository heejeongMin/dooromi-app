class SigninUser {
  String username;
  String password;


  SigninUser(
      this.username,
      this.password);

  String get getUserName => username;
  String get getPassword => password;

  Map<String, dynamic> toJson() => {
    "username" : this.username.toString(),
    "password": this.password.toString()
  };

  bool validate(){
    return username.isNotEmpty || password.isNotEmpty;
  }
}