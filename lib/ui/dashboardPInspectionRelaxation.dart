import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tivnqn/model/preparation/chartDataPInspection.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/model/preparation/chartDataPRelaxation.dart';
import 'package:tivnqn/model/preparation/pRelaxationfabricTable.dart';
import 'package:tivnqn/model/preparation/pRelaxationDataSource.dart';
import 'package:tivnqn/myFuntions.dart';

class DashBoardPInspectionRelaxation extends StatefulWidget {
  const DashBoardPInspectionRelaxation({super.key});

  @override
  State<DashBoardPInspectionRelaxation> createState() =>
      _DashBoardPInspectionRelaxationState();
}

class _DashBoardPInspectionRelaxationState
    extends State<DashBoardPInspectionRelaxation> {
  TextStyle rowTextStyle = TextStyle(
    fontSize: 8,
  );
  late PRelaxationDataSourceTable pRelaxationDataSourceTable;
  ChartSeriesController? chartControllerInspection;
  ChartSeriesController? chartControllerRelaxation;
  Legend myLegend = const Legend(
      itemPadding: 2,
      // height: '40%',
      textStyle: TextStyle(
          fontSize: 8, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.right,
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap);
  DataLabelSettings myDataLabelSettings = const DataLabelSettings(
    labelAlignment: ChartDataLabelAlignment.middle,
    isVisible: false,
    textStyle: TextStyle(
        fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
  );
  Future<void> refreshData() async {
    var temp = await g.sqlApp.sellectPRelaxationFabricTable();
    if (temp.length > 0) {
      setState(() {
        g.pRelaxationFabricTables.clear();
        g.pRelaxationFabricTables = temp;
        pRelaxationDataSourceTable = PRelaxationDataSourceTable(
            pRelaxationFabricTable: g.pRelaxationFabricTables);
      });
    }

    setState(() {
      chartControllerInspection?.updateDataSource(
          updatedDataIndexes:
              List<int>.generate(g.chartDataPInspection.length, (i) => i + 1));
      chartControllerRelaxation?.updateDataSource(
          updatedDataIndexes:
              List<int>.generate(g.chartDataPRelaxation.length, (i) => i + 1));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    pRelaxationDataSourceTable = PRelaxationDataSourceTable(
        pRelaxationFabricTable: g.pRelaxationFabricTables);
    refreshData();
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) {
      refreshData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return false
        // g.chartDataPRelaxation.isEmpty
        ? MyFuntions.noData()
        : Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "INSPECTION",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(2),
                            width: g.screenWidth - 30,
                            height: 77,
                            child: inspectionFabricChart()),
                      ],
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 3,
                ),
                Divider(thickness: 2),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "RELAXATION",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Floor     Customer     Line     Art#     Lot#     Color     BeginTime     Duration(hours)   Quantity(m)",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Container(
                            padding: EdgeInsets.all(1),
                            width: g.screenWidth - 30,
                            child: relaxationLayout()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget relaxationChart() {
    return SfCartesianChart(
        title: ChartTitle(text: 'RELAXATION FABRIC'),
        legend: myLegend,
        primaryXAxis: CategoryAxis(
          labelAlignment: LabelAlignment.center,
          labelPosition: ChartDataLabelPosition.inside,
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        series: <ChartSeries>[
          StackedBar100Series<ChartDataPRelaxation, String>(
              dataSource: g.chartDataPRelaxation,
              color: Colors.blue[200],
              dataLabelSettings: myDataLabelSettings,
              xValueMapper: (ChartDataPRelaxation data, _) => data.name,
              yValueMapper: (ChartDataPRelaxation data, _) => data.actual,
              name: "Actual",
              width: 0.8,
              spacing: 0.2),
          StackedBar100Series<ChartDataPRelaxation, String>(
              dataSource: g.chartDataPRelaxation,
              color: Colors.black12,
              dataLabelSettings: myDataLabelSettings,
              xValueMapper: (ChartDataPRelaxation data, _) => data.name,
              yValueMapper: (ChartDataPRelaxation data, _) => data.remain,
              name: "Remain",
              width: 0.8,
              spacing: 0.2)
        ]);
  }

  Widget relaxationLayout() {
    return Container(
        height: g.screenHeight - 150,
        // color: Colors.white,
        child: MasonryGridView.count(
          crossAxisSpacing: 0,
          padding: const EdgeInsets.all(0),
          itemCount: 12,
          crossAxisCount: 2,
          reverse: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blue[50],
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '''Shelve ${g.pRelaxationFabricTables[index * 5 + 0].getShelveNo}''',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500]),
                      ),
                    ),
                    // VerticalDivider(
                    //   thickness: 1,
                    //   color: Colors.white,
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getRow(index * 5 + 0),
                        getRow(index * 5 + 1),
                        getRow(index * 5 + 2),
                        getRow(index * 5 + 3),
                        getRow(index * 5 + 4),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  String getText(PRelaxationFabricTable input) {
    String output = '';
    output =
        '${input.getFloor}     ${input.getCustomer}     ${input.getLine}     ${input.getArtNo}     ${input.getLotNo}     ${input.getColor}     ${DateFormat("dd-MMM-yy hh:mm").format(
      input.getBeginTime,
    )}     ${input.getDurationHour}';
    return output;
  }

  Widget getRow(int index) {
    return Row(
      children: [
        Container(
          width: 15,
          child: Text(
            '${g.pRelaxationFabricTables[index].getFloor}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 40,
          child: Text(
            g.pRelaxationFabricTables[index].getCustomer == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getCustomer}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 15,
          child: Text(
            g.pRelaxationFabricTables[index].getLine == 0
                ? '-'
                : '${g.pRelaxationFabricTables[index].getLine}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 91,
          child: Text(
            g.pRelaxationFabricTables[index].getArtNo == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getArtNo}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 65,
          child: Text(
            g.pRelaxationFabricTables[index].getLotNo == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getLotNo}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 70,
          child: Text(
            g.pRelaxationFabricTables[index].getColor == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getColor}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 60,
          child: Text(
            g.pRelaxationFabricTables[index].customer == '-'
                ? '-'
                : '${DateFormat("dd-MMM hh:mm").format(
                    g.pRelaxationFabricTables[index].getBeginTime,
                  )}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 20,
          child: Text(
            g.pRelaxationFabricTables[index].customer == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getDurationHour}',
            style: rowTextStyle,
          ),
        ),
        Container(
          width: 35,
          child: Text(
            g.pRelaxationFabricTables[index].customer == '-'
                ? '-'
                : '${g.pRelaxationFabricTables[index].getQty.toStringAsFixed(1)}',
            style: rowTextStyle,
          ),
        ),
      ],
    );
  }

  Widget relaxationTable(PRelaxationDataSourceTable dataSource) {
    TextStyle textStyle = TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: Colors.blue,
      ),
      child: SfDataGrid(
          source: dataSource,
          onQueryRowHeight: (details) {
            // Set the row height as 70.0 to the column header row.
            return details.rowIndex == 0 ? 40.0 : 35.0;
          },
          columns: <GridColumn>[
            GridColumn(
                columnName: 'shelveNo',
                width: 60,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SHELVE'.toUpperCase(),
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'fabric',
                width: 70,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'fabric'.toUpperCase(),
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'customer',
                width: 90,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'customer'.toUpperCase(),
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'line',
                width: 35,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Line'.toUpperCase(),
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'artLotNo',
                width: 110,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '''Art #
Lot #''',
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'color',
                width: 105,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Color'.toUpperCase(),
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'qty',
                width: 45,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Qty',
                      style: textStyle,
                    ))),
            GridColumn(
                columnName: 'time',
                width: 140,
                label: Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '''Time Begin
Actual/plan (hours)''',
                      style: textStyle,
                    ))),
          ]),
    );
  }

  Widget inspectionFabricChart() {
    return SfCartesianChart(
        legend: myLegend,
        primaryXAxis: CategoryAxis(
          labelAlignment: LabelAlignment.center,
          labelPosition: ChartDataLabelPosition.inside,
          labelStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        primaryYAxis:
            NumericAxis(isVisible: false, labelStyle: TextStyle(fontSize: 8)),
        series: <ChartSeries>[
          StackedBar100Series<ChartDataPInspection, String>(
              color: Colors.green[300],
              dataSource: g.chartDataPInspection,
              dataLabelSettings: myDataLabelSettings,
              xValueMapper: (ChartDataPInspection data, _) => data.name,
              yValueMapper: (ChartDataPInspection data, _) => data.actual,
              name: "Actual",
              width: 0.8,
              spacing: 0.2),
          StackedBar100Series<ChartDataPInspection, String>(
              color: Colors.black26,
              dataSource: g.chartDataPInspection,
              dataLabelSettings: myDataLabelSettings,
              xValueMapper: (ChartDataPInspection data, _) => data.name,
              yValueMapper: (ChartDataPInspection data, _) => data.remain,
              name: "Remain",
              width: 0.8,
              spacing: 0.2)
        ]);
  }
}
