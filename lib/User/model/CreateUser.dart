class CreateUser {
  String username;
  String password;
  String fullname;
  String email;

  CreateUser(
      this.username,
      this.password,
      this.fullname,
      this.email);

  String get getUserName => username;
  String get getPassword => password;
  String get getFullname => fullname;
  String get getEmail => email;

  Map<String, dynamic> toJson() => {
    "username" : this.username.toString(),
    "password": this.password.toString(),
    "fullname" :  this.fullname.trim(),
    "email" : this.email.trim()
  };

  bool validate(){
    return username.isNotEmpty || password.isNotEmpty
        || fullname.isNotEmpty || email.isNotEmpty;
  }
}