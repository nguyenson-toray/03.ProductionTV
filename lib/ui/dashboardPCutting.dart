import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/model/preparation/.chartDataPCutting.dart';
import 'package:tivnqn/myFuntions.dart';

class DashboardPCutting extends StatefulWidget {
  const DashboardPCutting({super.key});

  @override
  State<DashboardPCutting> createState() => _DashboardPCuttingState();
}

class _DashboardPCuttingState extends State<DashboardPCutting> {
  ChartSeriesController? chartControllerCutting;
  Legend myLegend = const Legend(
      itemPadding: 3,
      // height: '40%',
      textStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.left,
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap);
  DataLabelSettings myDataLabelSettings = const DataLabelSettings(
    labelAlignment: ChartDataLabelAlignment.auto,
    labelPosition: ChartDataLabelPosition.outside,
    alignment: ChartAlignment.center,
    isVisible: false,
    textStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
  );
  @override
  void initState() {
    // TODO: implement initState
    refreshData();
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) {
      refreshData();
    });
    super.initState();
  }

  Future<void> refreshData() async {
    var temp = await g.sqlApp.sellectPCutting();
    if (temp.length != 0) {
      g.pCuttings = temp;
      g.chartDataPCuttings.clear();
      g.pCuttings.forEach((element) {
        var a = element.planQty as num;
        var b = element.actualQty as num;
        ChartDataPCutting temp = ChartDataPCutting(
            name:
                'Line: ${element.line} - ${element.band} - Style:${element.styleNo} -Color:  ${element.color} - Size: ${element.size}   #️⃣Process: ${element.actualQty}/${element.planQty}',
            actual: element.actualQty as num,
            remain: a - b);
        g.chartDataPCuttings.add(temp);
        setState(() {
          chartControllerCutting?.updateDataSource(
              updatedDataIndexes: List<int>.generate(
                  g.chartDataPCuttings.length, (i) => i + 1));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return g.chartDataPCuttings.isEmpty
        ? MyFuntions.noData()
        : Container(
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: SfCartesianChart(
                // title: ChartTitle(text: 'CUTTING'),
                legend: myLegend,
                primaryXAxis: CategoryAxis(
                  labelPosition: ChartDataLabelPosition.inside,
                  labelStyle: TextStyle(
                    // fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                series: <ChartSeries>[
                  StackedBar100Series<ChartDataPCutting, String>(
                      color: Colors.blue[300],
                      dataSource: g.chartDataPCuttings,
                      dataLabelSettings: myDataLabelSettings,
                      xValueMapper: (ChartDataPCutting data, _) => data.name,
                      yValueMapper: (ChartDataPCutting data, _) => data.actual,
                      name: "Actual",
                      width: 0.8,
                      spacing: 0.2),
                  StackedBar100Series<ChartDataPCutting, String>(
                      color: Colors.black12,
                      dataSource: g.chartDataPCuttings,
                      dataLabelSettings: myDataLabelSettings,
                      xValueMapper: (ChartDataPCutting data, _) => data.name,
                      yValueMapper: (ChartDataPCutting data, _) => data.remain,
                      name: "Remain",
                      width: 0.8,
                      spacing: 0.2)
                ]));
  }
}
