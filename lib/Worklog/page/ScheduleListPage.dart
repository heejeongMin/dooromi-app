import 'dart:collection';

import 'package:dooromi/Worklog/function/DoroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/DateAndTimePage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  DataTableSource _data = RowData();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('두루미'),
      ),
      body: new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(40),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              "근무일정 목록",
              style: new TextStyle(
                  fontSize:25.0,
                  color: Colors.white,
                  fontFamily: "Roboto"
              ),
            ),
          ),
          Padding(
            child:
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '거래처명으로 검색',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('검색'),
                  onPressed: () => {},
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 50.0),
          ),

          SizedBox(
            height: 10,
          ),
          PaginatedDataTable(
            source: _data,
            //header: Text('My Products'),
            columns: [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('거래처명')),
              DataColumn(label: Text('장소')),
              DataColumn(label: Text('시간')),
            ],
            columnSpacing: 100,
            horizontalMargin: 10,
            rowsPerPage: 8,
            showCheckboxColumn: false,
          ),

          Padding(
            child:
            new ElevatedButton(
                child: Text('근무일정 생성'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new DateAndTimePage(worklog: null))
                  );
                },

            ),

            padding: const EdgeInsets.all(24.0),
          )
        ],
      ),
      )

    );
  }

}



void buttonPressed(){}

// The "soruce" of the table
class RowData extends DataTableSource {
  Future<List<Worklog>> _worklogList = DoroomiAPI.getAllWorklog();


  RowData(){
    buildFutureBuilder();
  }

  final List<Map<String, dynamic>> _data = List.generate(
      10,
          (index) => {
        "no": index+1,
        "name": "crane $index",
        "place": "seoul" + Random().nextInt(100).toString(),
        "time": Random().nextInt(19).toString() + ":" + Random().nextInt(60).toString() + "~" + "20:00"
      });

  bool get isRowCountApproximate => false;
  int get rowCount => _data.length;
  int get selectedRowCount => 0;


  DataRow getRow(int index) {

    print(_data);

    
    return DataRow(cells: [
      DataCell(Text(index.toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text("희정3", style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["place"].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["time"].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
    ]);
  }


  FutureBuilder<List<Worklog>> buildFutureBuilder() {

    print("12312312313123123123123");

    return FutureBuilder<List<Worklog>>(
      future: _worklogList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("123");

        } else if (snapshot.hasError) {
          print("456");
          return Text('${snapshot.error}');
        }

        print("789");
        return const CircularProgressIndicator();
      },
    );
  }

}

