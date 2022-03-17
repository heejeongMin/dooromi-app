// import 'package:flutter/material.dart';
// import '../model/CreateUser.dart';
// import '../page/UserProfilePage.dart';
//
// class UserModifyPage extends StatefulWidget {
//   final User user;
//
//   UserModifyPage({required this.user});
//
//   @override
//   _UserModifyPageState createState() => new _UserModifyPageState(user: user);
// }
//
// class _UserModifyPageState extends State<UserModifyPage> {
//   final User user;
//
//   _UserModifyPageState({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     var _name = user.name;
//     var _phoneNumber = user.phoneNumber;
//     var _birthdate = user.birthdate;
//     var _address = user.address;
//     var _nationality = user.nationality;
//
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Login Page'),
//       ),
//       body:
//       new SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       padding: const EdgeInsets.all(40),
//       child:
//       new Container(
//         child:
//         new Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               new Padding(
//                 child:
//                 new Text(
//                   "이름",
//                   style: new TextStyle(fontSize:15.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 5.0),
//               ),
//
//               new Padding(
//                 child:
//                 new TextField(
//                   decoration: InputDecoration(
//                     labelText: _name,
//                   ),
//                   onChanged: (text){
//                     if (text.trim().isNotEmpty) {
//                       _name = text;
//                     } else {
//                       _name = user.name;
//                     }
//                   },
//                   style: new TextStyle(fontSize:12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
//               ),
//
//               new Padding(
//                 child:
//                 new Text(
//                   "전화번호",
//                   style: new TextStyle(fontSize:15.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
//               ),
//
//               new Padding(
//                 child:
//                 new TextField(
//                   decoration: InputDecoration(
//                     labelText: _phoneNumber,
//                   ),
//                   onChanged: (text){
//                     if (text.trim().isNotEmpty) {
//                       _phoneNumber = text;
//                     } else {
//                       _phoneNumber = user.phoneNumber;
//                     }
//                   },
//                   style: new TextStyle(fontSize:12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
//               ),
//
//               new Padding(
//                 child:
//                 new Text(
//                   "생년월일",
//                   style: new TextStyle(fontSize:15.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
//               ),
//
//               new Padding(
//                 child:
//                 new TextField(
//                   decoration: InputDecoration(
//                     labelText: _birthdate,
//                   ),
//                   onChanged: (text){
//                     if (text.trim().isNotEmpty) {
//                       _birthdate = text;
//                     } else {
//                       _birthdate = user.birthdate;
//                     }
//                   },
//                   style: new TextStyle(fontSize:12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
//               ),
//
//               new Padding(
//                 child:
//                 new Text(
//                   "주소",
//                   style: new TextStyle(fontSize:15.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
//               ),
//
//               new Padding(
//                 child:
//                 new TextField(
//                   decoration: InputDecoration(
//                     labelText: _address,
//                   ),
//                   onChanged: (text){
//                     if (text.trim().isNotEmpty) {
//                       _address = text;
//                     } else {
//                       _address = user.address;
//                     }
//                   },
//                   style: new TextStyle(fontSize:12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
//               ),
//
//               new Padding(
//                 child:
//                 new Text(
//                   "국적",
//                   style: new TextStyle(fontSize:15.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w400,
//                       fontFamily: "Roboto"),
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
//               ),
//
//               new Padding(
//                 child:
//                 new DropdownButton<String>(
//                   onChanged: (value) {
//                     setState(() {
//                       _nationality = value.toString();
//                     });
//                   },
//                   value: "대한민국",
//                   style: new TextStyle(fontSize:12.0,
//                       color: const Color(0xFF202020),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                   items: <DropdownMenuItem<String>>[
//                     const DropdownMenuItem<String>(value: "대한민국",
//                         child: const Text("대한민국")),
//                     const DropdownMenuItem<String>(value: "Child 2",
//                         child: const Text("Child 2")),
//                     const DropdownMenuItem<String>(value: "Child 3",
//                         child: const Text("Child 3")),
//                   ],
//                 ),
//
//                 padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
//               ),
//
//               new Padding(
//                 child:
//                 new ElevatedButton(
//                   //color: const Color(0xFFe0e0e0),
//                   child:
//                   new Text(
//                     "정보 수정",
//                     style: new TextStyle(fontSize:12.0,
//                         color: const Color(0xFF000000),
//                         fontWeight: FontWeight.w200,
//                         fontFamily: "Roboto"),
//                   ),
//
//                   onPressed: () {
//                     final user = User(_name, _phoneNumber, _birthdate, _address, _nationality);
//
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => new UserProfilePage(user: user))
//                     );
//                   },
//                 ),
//
//                 padding: const EdgeInsets.all(24.0),
//               )
//             ]
//
//         ),
//
//         padding: const EdgeInsets.all(0.0),
//         alignment: Alignment.center,
//       ),
//       )
//
//
//     );
//   }
// }
//
// /*User validation(User user) {
//   if (user.name.trim().isEmpty) {
//     user.setName(user.getName);
//   }
//   if (user.phoneNumber.trim().isEmpty) {
//     user.setPhoneNumber(user.getPhoneNumber);
//   }
//   if (user.birthdate.trim().isEmpty) {
//     user.setBirthdate(user.getBirthdate);
//   }
//   if (user.address.trim().isEmpty) {
//     user.setAddress(user.getAddress);
//   }
//   if (user.nationality.trim().isEmpty) {
//     user.setNationality(user.getNationality);
//   }
//
//   return user;
// }*/