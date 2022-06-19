import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  bool _isInitialValue = true;

  @override
  void initState(){
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => {
      setState(() {
        _isInitialValue = !_isInitialValue;
      })
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              constraints: BoxConstraints(
                maxWidth: _isInitialValue ? 200 : 100,
                maxHeight: _isInitialValue ? 200 : 100,
              ),
              child: Image.asset('assets/image/logo.png')
            )
          ],
        ),
      ),
    );
  }
//
// @override
// Widget build(BuildContext context) {
//   return new Scaffold(
//       body:
//       SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (BuildContext buildContext, Widget child) {
//
//             },
//           )
//
//
//           Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
//                   child: Center(
//
//                     child: Container(
//                         width: _animation.value,
//                         /*decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(50.0)),*/
//                         child: Image.asset('assets/image/logo.png')
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
//                   child: Center(
//                     child: Text("환영합니다!"),
//                   ),
//                 )
//               ])
//       )
//   );
// }
}
