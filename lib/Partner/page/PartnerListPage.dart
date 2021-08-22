import 'package:flutter/material.dart';
import 'dart:math';
import '../page/PartnerCreatePage.dart';

class PartnerListPage extends StatefulWidget {
  const PartnerListPage({Key? key}) : super(key: key);

  @override
  _PartnerListPageState createState() => _PartnerListPageState();
}

class _PartnerListPageState extends State<PartnerListPage> {
  DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('거래처 관리'),
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
                DataColumn(label: Text('전화번호'))
              ],
              columnSpacing: 100,
              horizontalMargin: 10,
              rowsPerPage: 8,
              showCheckboxColumn: false,
            ),

            Padding(
              child:
              new ElevatedButton(
                child:
                new Text(
                  "거래처 등록",
                  style: new TextStyle(fontSize:12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new PartnerCreatePage())
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
        "name": "Crane $index",
        "phoneNumber": "010-" + Random().nextInt(10000).toString() + "-" + Random().nextInt(10000).toString()
      });

  bool get isRowCountApproximate => false;
  int get rowCount => _data.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['no'].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["name"], style: TextStyle(fontWeight: FontWeight.w500),)),
      DataCell(Text(_data[index]["phoneNumber"].toString(), style: TextStyle(fontWeight: FontWeight.w500),)),
    ]);
  }
}