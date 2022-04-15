import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/model/WorklogRes.dart';
import 'package:dooromi/Worklog/page/DateAndTimePage.dart';
import 'package:dooromi/Worklog/page/WorklogDetailPage.dart';
import 'package:flutter/material.dart';

import 'WorklogToExcelPage.dart';

class ScheduleListPage extends StatefulWidget {
  late final String partnerName;

  ScheduleListPage({required this.partnerName});

  @override
  _ScheduleListPageState createState() =>
      _ScheduleListPageState(partnerName: partnerName);
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final String partnerName;
  List<Map<String, dynamic>> tableSource = [];
  DataTableSource data = new RowData(data: [], totalItems: 0);
  var offset = 0;
  late Future<WorklogRes> worklogRes;

  _ScheduleListPageState({required this.partnerName});

  @override
  void initState() {
    super.initState();
    worklogRes = DooroomiAPI.getAllWorklog(partnerName, offset);
  }

  void syncData(worklogRes) {
    tableSource = [];
    worklogRes.worklogList.forEach((element) {
      Map<String, dynamic> map = {
        "id": element.id,
        "name": element.partner!.companyName,
        "place": element.location,
        "date": element.date,
        "startTime": element.startTime,
        "endTime": element.endTime,
        "equipmentId": element.equipment!.id,
        "equipmentName": element.equipment!.equipment,
        "equipmentSpec": element.equipment!.spec,
        "spec": element.equipment!.spec,
        "partnerId": element.partner!.id,
        "companyName": element.partner!.companyName
      };
      tableSource.add(map);
    });

    if (worklogRes.totalItems - tableSource.length > 8) offset++;
    this.data =
        new RowData(data: tableSource, totalItems: worklogRes.totalItems);
    (data as RowData).scheduleListPageBuildContext = context;
  }

  @override
  Widget build(BuildContext context) {
    var _partnerName = "";

    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        textAlign: TextAlign.center,
        child: FutureBuilder<WorklogRes>(
            future: worklogRes,
            builder:
                (BuildContext context, AsyncSnapshot<WorklogRes> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                syncData(snapshot.requireData);

                children = [
                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: new Text(
                      "근무일정 목록",
                      style: new TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontFamily: "Roboto"),
                    ),
                  ),
                  Padding(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: '거래처명으로 검색',
                            ),
                            onChanged: (text) {
                              _partnerName = text;
                            },
                          ),
                        ),
                        ElevatedButton(
                          child: Text('검색'),
                          onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              settings:
                                  RouteSettings(name: "/ScheduleListPage"),
                              builder: (context) =>
                                  ScheduleListPage(partnerName: _partnerName),
                            ))
                          },
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
                      // DataColumn(
                      //     label: Container(
                      //       width: MediaQuery.of(context).size.width * .05,
                      //       child: Text('No'),
                      //     ),
                      // ),
                      DataColumn(
                        label: Container(
                          width: MediaQuery.of(context).size.width * .25,
                          child: Text('거래처'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: MediaQuery.of(context).size.width * .25,
                          child: Text('장소'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: MediaQuery.of(context).size.width * .2,
                          child: Text('날짜'),
                        ),
                      ),
                    ],
                    columnSpacing: 5,
                    horizontalMargin: 10,
                    rowsPerPage: 8,
                    showCheckboxColumn: true,
                  ),
                  new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              child: Text('엑셀로 추출'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings: RouteSettings(
                                      name: "/WorklogToExcelPage"),
                                  builder: (context) =>
                                      new WorklogToExcelPage(),
                                ));
                              },
                            )),
                        new Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              child: Text('근무일정 생성'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings:
                                      RouteSettings(name: "/DateAndTimePage"),
                                  builder: (context) =>
                                      new DateAndTimePage(worklog: null),
                                ));
                              },
                            )),
                      ]),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      )));
            }));
  }
}

class RowData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final int totalItems;
  late BuildContext scheduleListPageBuildContext;

  RowData({required this.data, required this.totalItems});

  bool get isRowCountApproximate => false;

  int get rowCount => data.length;

  int get selectedRowCount => 0;

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
          Text(
            data[index]["companyName"],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
      DataCell(
          Text(
            data[index]["place"].toString(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
      DataCell(
          Text(
            data[index]["date"].toString(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
    ]);
  }

  void buttonPressed(value) {
    Worklog wl =
        new Worklog(value["date"], value["startTime"], value["endTime"]);
    wl.setId(value["id"]);
    wl.setLocation(value["place"]);
    wl.setEquipment(new Equipment(value["equipmentId"], value["equipmentName"],
        value["equipmentSpec"], ""));
    wl.setPartner(
        Partner.simplePartner(value["partnerId"], value["companyName"]));

    Navigator.push(
        scheduleListPageBuildContext,
        MaterialPageRoute(
            builder: (scheduleListPageBuildContext) =>
                new WorklogDetailPage(worklog: wl)));
  }
}
