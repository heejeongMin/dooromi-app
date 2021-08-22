import 'package:dooromi/Worklog/model/Worklog.dart';

import 'package:flutter/material.dart';

import 'WorklogDetailPage.dart';

class ClientPage extends StatefulWidget {
  final Worklog worklog;


  ClientPage({required this.worklog});

  @override
  _ClientPageState createState() => new _ClientPageState(worklog: worklog);
}

class _ClientPageState extends State<ClientPage> {

  final Worklog worklog;
  final _clientList = ['쌍둥이크레인', '성신크레인'];
  var _selectedClient = '쌍둥이크레인';

  _ClientPageState({required this.worklog});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: Text('두루미'),
        ),
        body:
        new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child:
          new Column(
              children: <Widget>[
                new Container(
                  width: 250,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "거래처 입력",
                    style: new TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                        fontFamily: "Roboto"
                    ),
                  ),
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                        child:Text('거래처'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                        child: DropdownButton(
                            value: _selectedClient,
                            items: _clientList.map((value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value)
                              );
                            }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                _selectedClient = value as String;
                              });
                            }
                        ),
                      ),
                    ]
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                      ElevatedButton(
                        child: Text('저장'),
                        onPressed: () {
                          worklog.setClient(_selectedClient);

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('근무일정 저장'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text('해당 내용으로 저장하시겠습니까?'),
                                      Text(worklog.toString())
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      child: Text('저장'),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        this.saveWorklog(worklog);
                                      },
                                  ),
                                  TextButton(
                                    child: Text('취소'),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                      },
                    )
                ),
              ]
          ),
        )
    );
  }

  saveWorklog(worklog){
    //todo call api to save worklog
    //todo loading bar?

    String message = (true)? "성공적으로 저장되었습니다." : "저장에 실패하였습니다.";


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new WorklogDetailPage(worklog: worklog))
                  );
                },
              ),
            ],
          );
        }
    );
  }


}