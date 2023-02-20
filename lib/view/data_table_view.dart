import 'package:flutter/material.dart';

class DataTableView extends StatelessWidget {
  const DataTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Table"),),
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columns: [
                  setDataColumn("No."),
                  setDataColumn("First name"),
                  setDataColumn("Last name")
                ],
                rows: [
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                  setDataRow("1", "Prakash", "Parmar"),
                  setDataRow("2", "Pro", "Parmar"),
                ],
            border: TableBorder.symmetric(inside: BorderSide(color: Colors.blue),
            outside: BorderSide(color: Colors.red, width: 10)),
            columnSpacing: 50,),
          ),
        ),
      ),
    );
  }

  DataColumn setDataColumn(String text){
    var isNo = text == "No." ? true : false;
    return DataColumn(label: Text(text), numeric: isNo);
  }

  DataRow setDataRow(String no, String fName, String lName){
    return DataRow(cells: [
      DataCell(Text(no)),
      DataCell(Text(fName), showEditIcon: true),
      DataCell(Text(lName), showEditIcon: true)
    ]);
  }
}
