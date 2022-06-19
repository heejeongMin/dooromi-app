import 'dart:convert';

import 'package:dooromi/User/model/AuthToken.dart';
import 'package:dooromi/User/model/CreateUser.dart';
import 'package:dooromi/User/model/DetailUser.dart';
import 'package:dooromi/User/model/SigninUser.dart';
import 'package:dooromi/User/model/WorkInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Main.dart';

class Env {
  static final env = 'heroku';
  static final host = Env.env == 'local' ? '10.0.2.2:5000' : 'peaceful-mesa-17441.herokuapp.com' ;
}
