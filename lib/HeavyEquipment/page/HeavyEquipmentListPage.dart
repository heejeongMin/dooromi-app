import 'package:dooromi/HeavyEquipment/function/HeavyEquipmentAPI.dart';
import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:flutter/material.dart';

import 'HeavyEquipmentCreatePage.dart';
import 'HeavyEquipmentDetailPage.dart';

class HeavyEquipmentListPage extends StatefulWidget {
  const HeavyEquipmentListPage({Key? key}) : super(key: key);

  @override
  _HeavyEquipmentListPageState createState() => _HeavyEquipmentListPageState();
}

class _HeavyEquipmentListPageState extends State<HeavyEquipmentListPage> {
  List<Map<String, dynamic>> tableSource = [];
  DataTableSource data = new RowData(data: [], totalItems: 0);
  var offset = 0;

  @override
  void initState() {
    super.initState();

    HeavyEquipmentAPI.getAllHeavyEquipment().then((result) {
      int size = 0;
      result.equipments.forEach((element) {
        ++size;
        Map<String, dynamic> map = {
          "id": element.id,
          "equipment": element.equipmentKR(),
          "spec": element.spec,
          "halfDayAmount": element.halfDayAmount,
          "fullDayAmount": element.fullDayAmount,
          "nightShiftAmount": element.nightShiftAmount,
          "createdAt": element.createdAt
        };
        tableSource.add(map);
      });

      setState(() {
        if (size - tableSource.length > 5) offset++;
        this.data = new RowData(data: tableSource, totalItems: size);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    (data as RowData).context = context;

    return Scaffold(
        appBar: AppBar(
          title: Text('두루미'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                width: 150,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30)),
                child: new Text(
                  "나의 장비",
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Roboto"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PaginatedDataTable(
                source: data,
                columns: [
                  DataColumn(
                    label: Container(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Text('장비명'),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Text('spec'),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Text('등록일자'),
                    ),
                  ),
                ],
                columnSpacing: 5,
                horizontalMargin: 10,
                rowsPerPage: 5,
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
                          child: Text('장비 등록'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              settings: RouteSettings(
                                  name: "/HeavyEquipmentCreatePage"),
                              builder: (context) =>
                                  new HeavyEquipmentCreatePage(),
                            ));
                          },
                        )),
                  ])
            ],
          ),
        ));
  }
}

class RowData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final int totalItems;
  late BuildContext context;

  RowData({required this.data, required this.totalItems});

  bool get isRowCountApproximate => false;

  int get rowCount => data.length;

  int get selectedRowCount => 0;

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
          Text(
            data[index]["equipment"] ?? '장비',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onLongPress: () {
        onLongPress(data[index]);
      }, onTap: () {
        onTap(data[index]);
      }),
      DataCell(
          Text(
            data[index]["spec"],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onLongPress: () {
        onLongPress(data[index]);
      }, onTap: () {
        onTap(data[index]);
      }),
      DataCell(
          Text(
            data[index]["createdAt"],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onLongPress: () {
        onLongPress(data[index]);
      }, onTap: () {
        onTap(data[index]);
      })
    ]);
  }

  void onTap(value) {
    Equipment equipment = Equipment(
        value["id"],
        value["equipment"],
        value["spec"],
        value["halfDayAmount"],
        value["fullDayAmount"],
        value["nightShiftAmount"],
        value["createdAt"]);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (partnerListContext) =>
                new HeavyEquipmentDetailPage(equipment: equipment)));
  }

  void onLongPress(value) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('나의 장비 삭제'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('삭제하시겠습니까?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('삭제'),
                onPressed: () {
                  HeavyEquipmentAPI.deleteEquipment(value["id"], context);
                },
              ),
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
