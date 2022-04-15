import 'dart:collection';

import 'package:dooromi/Partner/funciton/PartnerApi.dart';
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Partner/model/PartnerRes.dart';
import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:flutter/material.dart';


class ClientPage extends StatefulWidget {
  final Worklog worklog;

  ClientPage({required this.worklog});

  @override
  _ClientPageState createState() =>
      new _ClientPageState(worklog: worklog);
}

class _ClientPageState extends State<ClientPage> {
  final Future<PartnerRes> partnerRes =
      PartnerApi.getAllPartner(0);
  final Worklog worklog;
  List<Partner> partnerList = [];
  var _selectedClient = '';

  _ClientPageState({required this.worklog});

  @override
  void initState() {
    super.initState();
  }

  void syncData(partnerRes) {
    partnerList = partnerRes.partners;
    if(_selectedClient.isEmpty) {
      _selectedClient = partnerRes.partners.first.companyName;
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<PartnerRes>(
        future: partnerRes,
        builder:
          (BuildContext context, AsyncSnapshot<PartnerRes> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              syncData(snapshot.requireData);

              children =  <Widget>[
                new Container(
                  width: 250,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.brown,
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
                            items: partnerList.map((value) {
                              return DropdownMenuItem(
                                  value: value.companyName,
                                  child: Text(value.companyName));
                            }).toList(),
                            onChanged: (value){
                              print("dddddd" + value!.toString());
                              setState(() {
                                _selectedClient = value as String;
                              });
                              print("_selectedClient" +
                                  _selectedClient);

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
                        partnerList.forEach((element) {
                          if(element.companyName == _selectedClient) {
                            worklog.setPartner(element);
                            return;
                          }
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext newContext) {
                              return AlertDialog(
                                title: Text('근무일정 저장'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text('해당 내용으로 저장하시겠습니까?'),
                                      Text(worklog.forDialog())
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('저장'),
                                    onPressed: (){
                                      Navigator.of(context,rootNavigator: true).pop();
                                      DooroomiAPI.saveWorklog(worklog, context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('취소'),
                                    onPressed: (){
                                      Navigator.of(context,rootNavigator: true).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    )
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }

            return Scaffold(
                appBar: AppBar(
                  title: Text('두루미'),
                ),
                body: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(40),
                    child: new Column(
                      children: children,
                    )));
          }
      )
    );
  }
}