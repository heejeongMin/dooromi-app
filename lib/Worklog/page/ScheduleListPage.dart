
import 'package:dooromi/Worklog/function/DoroomiAPI.dart';
import 'package:dooromi/Worklog/page/DateAndTimePage.dart';
import 'package:flutter/material.dart';


class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List<Map<String, dynamic>> tableSource = [];
  DataTableSource data = new RowData(data: []);

  @override
  void initState() {
    super.initState();

    DoroomiAPI.getAllWorklog().then((result) {
      result.forEach((element) {
        Map<String, dynamic> map =
          {
            "no" : 0,
            "name" : element.client,
            "place" :  element.location,
            "time" : element.date
          };
        tableSource.add(map);
      });

      setState(() {
        this.data = new RowData(data: tableSource);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('두루미'),
          ),
          body: SingleChildScrollView(
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
                  source: data,
                  //header: Text('My Products'),
                  columns: [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('거래처')),
                    DataColumn(label: Text('장소')),
                    DataColumn(label: Text('시간')),
                  ],
                  columnSpacing: 5,
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


class RowData extends DataTableSource {
  final List<Map<String, dynamic>> data;

  RowData({required this.data});

  bool get isRowCountApproximate => false;
  int get rowCount => data.length;
  int get selectedRowCount => 0;

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(index.toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))),
      DataCell(Text(data[index]["name"]?? '임시거래처', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),)),
      DataCell(Text(data[index]["place"].toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),)),
      DataCell(Text(data[index]["time"].toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),)),
    ]);
  }
}