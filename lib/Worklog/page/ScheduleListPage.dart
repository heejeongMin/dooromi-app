import 'package:dooromi/Worklog/page/DateAndTimePage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('근무일정 목록'),
      ),
      body:
      new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(40),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200,
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
    return DataRow(cells: [
      DataCell(Text(_data[index]['no'].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["name"], style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["place"].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["time"].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
    ]);
  }
}