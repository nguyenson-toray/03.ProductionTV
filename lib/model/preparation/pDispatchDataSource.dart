import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tivnqn/model/preparation/pDispatch.dart';

class PDispatchDataSource extends DataGridSource {
  PDispatchDataSource({required List<PDispatch> pDispatch}) {
    _pDispatch = pDispatch
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                columnName: 'line',
                value: e.line,
              ),
              DataGridCell<String>(columnName: 'brand', value: e.brand),
              DataGridCell<String>(columnName: 'styleNo', value: e.styleNo),
              DataGridCell<int>(columnName: 'orderQty', value: e.orderQty),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<String>(
                  columnName: 'item1',
                  value: '${e.size1}\n${e.actualQty1}/${e.planQty1}'),
              DataGridCell<String>(
                  columnName: 'item2',
                  value: e.planQty2! > 0
                      ? '${e.size2}\n${e.actualQty2}/${e.planQty2}'
                      : ''),
              DataGridCell<String>(
                  columnName: 'item3',
                  value: e.planQty3! > 0
                      ? '${e.size3}\n${e.actualQty3}/${e.planQty3}'
                      : ''),
              DataGridCell<String>(
                  columnName: 'total',
                  value:
                      '${((e.actualQty1! + e.actualQty2! + e.actualQty3!) / (e.planQty1! + e.planQty2! + e.planQty3!) * 100).toStringAsFixed(0)}%'),
            ]))
        .toList();
  }

  List<DataGridRow> _pDispatch = [];

  @override
  List<DataGridRow> get rows => _pDispatch;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Colors.grey,
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            color: dataGridCell.value.toString().contains('/')
                ? Colors.blue[50]
                : Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5.0),
            child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(fontSize: 17),
            ),
          );
        }).toList());
  }
}
