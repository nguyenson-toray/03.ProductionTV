import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tivnqn/model/preparation/pRelaxationfabricTable.dart';

class PRelaxationDataSourceTable extends DataGridSource {
  PRelaxationDataSourceTable(
      {required List<PRelaxationFabricTable> pRelaxationFabricTable}) {
    _pRelaxationFabricTable = pRelaxationFabricTable
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                columnName: 'shelveNo',
                value: e.getShelveNo,
              ),
              DataGridCell<String>(
                  columnName: 'fabric', value: e.getKindOfFabric),
              DataGridCell<String>(
                  columnName: 'customer', value: e.getCustomer),
              DataGridCell<String>(
                  columnName: 'line',
                  value: e.getCustomer == '-' ? '' : e.getLine.toString()),
              DataGridCell<String>(
                  columnName: 'artLotNo',
                  value: '''${e.getArtNo} ${e.getLotNo}'''),
              DataGridCell<String>(columnName: 'color', value: e.getColor),
              DataGridCell<String>(
                  columnName: 'qty',
                  value: e.getQty <= 0 ? "-" : e.getQty.toStringAsFixed(1)),
              DataGridCell<String>(
                  columnName: '''time''',
                  value: e.getQty <= 0
                      ? "-"
                      : DateTime.now().difference(e.getBeginTime).inHours >
                              e.getDurationHour
                          ? '''${DateFormat("dd-MMM-yy hh:mm").format(
                              e.getBeginTime,
                            )}
${e.getDurationHour} / ${e.getDurationHour}'''
                          : '''${DateFormat("dd-MMM-yy hh:mm").format(
                              e.getBeginTime,
                            )}
${DateTime.now().difference(e.getBeginTime).inHours} / ${e.getDurationHour}'''),
            ]))
        .toList();
  }

  List<DataGridRow> _pRelaxationFabricTable = [];

  @override
  List<DataGridRow> get rows => _pRelaxationFabricTable;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color? getRowBackgroundColor() {
      final int id = row.getCells()[0].value;
      if (id % 2 == 0) {
        return Colors.blue[50];
      }
      {
        return Colors.white;
      }
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(1.0),
            child: Text(
              dataGridCell.value.toString(),
              style: dataGridCell.value.toString().length == 23 &&
                      (dataGridCell.value.toString().substring(16, 17) ==
                          dataGridCell.value.toString().substring(21, 22))
                  ? const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      // fontWeight: FontWeight.bold
                    )
                  : const TextStyle(
                      fontSize: 13,
                    ),
            ),
          );
        }).toList());
  }
}
