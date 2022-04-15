import 'package:dooromi/Partner/funciton/PartnerApi.dart';
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Partner/model/PartnerRes.dart';
import 'package:dooromi/Partner/page/PartnerCreatePage.dart';
import 'package:dooromi/Partner/page/PartnerDetailPage.dart';
import 'package:flutter/material.dart';

class PartnerListPage extends StatefulWidget {
  const PartnerListPage({Key? key}) : super(key: key);

  @override
  _PartnerListPageState createState() => _PartnerListPageState();
}

class _PartnerListPageState extends State<PartnerListPage> {
  List<Map<String, dynamic>> tableSource = [];
  DataTableSource data = new RowData(data: [], totalItems: 0);
  var offset = 0;
  late Future<PartnerRes> partnerRes;

  @override
  void initState() {
    super.initState();
    partnerRes = PartnerApi.getAllPartner(offset);
  }

  void syncData(partnerRes) {
    tableSource = [];
    int size = 0;
    partnerRes.partners.forEach((element) {
      ++size;
      Map<String, dynamic> map = {
        "id": element.id,
        "partnerNumber": element.partnerNumber,
        "companyName": element.companyName,
        "ceoName": element.ceoName,
        "phoneNumber": element.phoneNumber,
        "createdBy": 1
      };
      tableSource.add(map);
    });

    if (size - tableSource.length > 8) offset++;
    this.data =
    new RowData(data: tableSource, totalItems: partnerRes.totalItems);
    (data as RowData).partnerListContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme
            .of(context)
            .textTheme
            .headline2!,
        textAlign: TextAlign.center,
        child: FutureBuilder<PartnerRes>(
          future: partnerRes,
          builder: (BuildContext context, AsyncSnapshot<PartnerRes> snapshot) {
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
                    "거래처 목록",
                    style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontFamily: "Roboto"),
                  ),
                ),
                // Padding(
                //   child:
                //   Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: TextField(
                //           decoration: InputDecoration(
                //             labelText: '거래처명으로 검색',
                //           ),
                //         ),
                //       ),
                //       ElevatedButton(
                //         child: Text('검색'),
                //         onPressed: () => {},
                //       ),
                //     ],
                //   ),
                //   padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 50.0),
                // ),
                //
                SizedBox(
                  height: 30,
                ),
                PaginatedDataTable(
                  source: data,
                  columns: [
                    DataColumn(
                      label: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .25,
                        child: Text('거래처명'),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .20,
                        child: Text('사장님'),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .25,
                        child: Text('전화번호'),
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
                            child: Text('거래처 생성'),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings:
                                RouteSettings(name: "/PartnerCreatePage"),
                                builder: (context) => new PartnerCreatePage(),
                              ));
                            },
                          )),
                    ])
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
          },
        )
    );
  }
}

class RowData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final int totalItems;
  late BuildContext partnerListContext;

  RowData({required this.data, required this.totalItems});

  bool get isRowCountApproximate => false;

  int get rowCount => data.length;

  int get selectedRowCount => 0;

  DataRow getRow(int index) {
    print("거래치리스트테스트");
    return DataRow(cells: [
      DataCell(
          Text(
            data[index]["companyName"] ?? '임시거래처',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
      DataCell(
          Text(
            data[index]["ceoName"].toString(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
      DataCell(
          Text(
            data[index]["phoneNumber"].toString(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ), onTap: () {
        buttonPressed(data[index]);
      }),
    ]);
  }

  void buttonPressed(value) {
    Partner partner = Partner.of(value["id"], value["partnerNumber"],
        value["companyName"], value["ceoName"], value["phoneNumber"], 1);

    Navigator.push(
        partnerListContext,
        MaterialPageRoute(
            builder: (partnerListContext) =>
            new PartnerDetailPage(partner: partner)));
  }
}
