import 'package:flutter/material.dart';
import '../model/User.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('기사 관리 시스템'),
      ),
      body:
      new Container(
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                child:
                new Image.network(
                  'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/17de4064-38a4-468b-b236-b743c5b67e8c/crane-icon-17.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210815%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210815T030907Z&X-Amz-Expires=86400&X-Amz-Signature=1113775ae4f2e01716a18019ccc3806e1d3eb9d35b5881bcb14f41c907591f0c&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22crane-icon-17.jpg%22',
                  fit: BoxFit.contain,
                  width: 250.0,
                  height: 250.0,
                ),

                padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 50.0),
              ),

              new Padding(
                child:
                new Image.network(
                  'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/ffdb02aa-a346-4f85-ad47-b5461a9e6b15/kakao_login_medium_wide.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210815%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210815T030929Z&X-Amz-Expires=86400&X-Amz-Signature=e3898487781bb6d43bb50819062dcc680a412610d9fc68803ae3cdf203c75b92&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22kakao_login_medium_wide.png%22',
                  fit: BoxFit.fill,
                ),

                padding: const EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 28.0),
              )
            ]

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),

    );
  }
}