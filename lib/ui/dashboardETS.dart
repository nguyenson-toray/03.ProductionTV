import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/model/etsMoQty.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/ui/announcement.dart';

class DashboardETS extends StatefulWidget {
  const DashboardETS({super.key});

  @override
  State<DashboardETS> createState() => _DashboardETSState();
}

class _DashboardETSState extends State<DashboardETS> {
  var leftCollumnW = g.screenWidth / 4 * 3 - 30 - 4;
  var rightCollumnW = g.screenWidth / 4 + 30 - 3;
  Widget titleWidgetETS = Container();
  Legend myLegendETSDaily = const Legend(
      itemPadding: 3,

      // height: '40%',
      textStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.bottom,
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap);
  Legend myLegendETSTotal = const Legend(
      itemPadding: 3,
      // height: '40%',
      textStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.bottom,
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap);
  DataLabelSettings myDataLabelSettingsETSDaily = const DataLabelSettings(
    labelAlignment: ChartDataLabelAlignment.auto,
    labelPosition: ChartDataLabelPosition.inside,
    alignment: ChartAlignment.center,
    showZeroValue: true,
    isVisible: true,
  );
  DataLabelSettings myDataLabelSettingsETSTotal = const DataLabelSettings(
    labelAlignment: ChartDataLabelAlignment.auto,
    labelPosition: ChartDataLabelPosition.inside,
    alignment: ChartAlignment.center,
    isVisible: false,
    textStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
  );
  ChartSeriesController? chartControllerETS;
  late Timer myTimer;
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    index = g.etsMOs.indexOf(g.currentMo);
    myTimer = Timer.periodic(Duration(seconds: g.config.getReloadSeconds),
        (timer) async {
      setState(() {});
      g.configs = await g.sqlApp.sellectConfigs();
      await MyFuntions.sellectDataETS(g.currentMo);

      if (g.isTVLine) {
        g.thongbao = await g.sqlApp.sellectThongBao();
        if (MyFuntions.checkThongBao()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Announcement()),
          );
        }
      }
    });
    if (g.autochangeLine) {
      Timer.periodic(const Duration(minutes: 5), (timer) async {
        index == g.etsMOs.length - 1 ? index = 0 : index++;

        setState(() {
          g.currentMo = g.etsMOs.elementAt(index);
          g.currentLine = g.lineETS.elementAt(index);
          MyFuntions.sellectDataETS(g.currentMo);
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: etsAppbar(),
      body: etsChart(),
    );
  }

  etsChart() {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              color: Colors.white,
              width: leftCollumnW,
              child: SfCartesianChart(
                  // legend: myLegendETSDaily,
                  title: ChartTitle(text: 'SẢN LƯỢNG HÔM NAY '),
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text:
                          'Công đoạn : 1..10 : Chuẩn bị           11..100: May',
                    ),
                    labelPosition: ChartDataLabelPosition.outside,
                    labelStyle: const TextStyle(
                      // fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  series: <CartesianSeries<EtsMoQty, String>>[
                    ColumnSeries<EtsMoQty, String>(
                        dataLabelSettings: myDataLabelSettingsETSDaily,
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataSource: g.etsMoQtys,
                        xValueMapper: (EtsMoQty data, _) =>
                            data.getGxNo.toString(),
                        yValueMapper: (EtsMoQty data, _) => data.getQtyToday,
                        color: const Color.fromRGBO(8, 142, 255, 1))
                  ])),
          Container(
              color: Colors.white,
              width: rightCollumnW,
              child: SfCartesianChart(
                  legend: myLegendETSTotal,
                  title: ChartTitle(text: 'TỔNG SẢN LƯỢNG LUỸ KẾ'),
                  primaryXAxis: CategoryAxis(
                    labelPosition: ChartDataLabelPosition.inside,
                    labelStyle: const TextStyle(
                      // fontSize: 13,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  series: <ChartSeries>[
                    StackedBar100Series<EtsMoQty, String>(
                        color: Colors.green,
                        dataSource: g.etsMoQtys,
                        // dataLabelSettings: myDataLabelSettingsETSTotal,
                        xValueMapper: (EtsMoQty data, _) =>
                            "${'${data.getGxNo}-' +
                            data.getGxName} : ${data.getQtyCommulative} pcs",
                        yValueMapper: (EtsMoQty data, _) =>
                            data.getQtyCommulative,
                        name: "Hoàn thành",
                        width: 0.8,
                        spacing: 0.2),
                    StackedBar100Series<EtsMoQty, String>(
                        color: Colors.black12,
                        dataSource: g.etsMoQtys,
                        // dataLabelSettings: myDataLabelSettingsETSTotal,
                        xValueMapper: (EtsMoQty data, _) =>
                            "${'${data.getGxNo}-' +
                            data.getGxName} : ${data.getQtyCommulative} pcs",
                        yValueMapper: (EtsMoQty data, _) =>
                            g.etsMoInfo.getQty - data.getQtyCommulative,
                        name: "Còn lại",
                        width: 0.8,
                        spacing: 0.2)
                  ])),
        ],
      ),
    );
  }

  etsAppbar() {
    return AppBar(
      toolbarHeight: g.appBarH,
      centerTitle: true,
      backgroundColor: Colors.blue,
      elevation: 6.0,
      leadingWidth: 95,
      leading: MyFuntions.logo(),
      actions: g.isTVControl
          ? [
              InkWell(
                  onTap: () {
                    index == 0 ? index = g.etsMOs.length - 1 : index--;
                    g.currentMo = g.etsMOs.elementAt(index);
                    g.currentLine = g.lineETS.elementAt(index);
                    print(g.currentMo);
                    setState(() {
                      MyFuntions.sellectDataETS(g.currentMo);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  )),
              InkWell(
                  onTap: () {
                    index == g.etsMOs.length - 1 ? index = 0 : index++;
                    g.currentMo = g.etsMOs.elementAt(index);
                    g.currentLine = g.lineETS.elementAt(index);
                    setState(() {
                      MyFuntions.sellectDataETS(g.currentMo);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  )),
              Switch(
                value: g.autochangeLine,
                onChanged: (value) {
                  setState(() {
                    g.autochangeLine = value;
                  });
                },
              ),
              const Text(
                '''Auto Change Line 
  After 5 Minutes''',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ]
          : [],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyFuntions.clockAppBar(context),
          MyFuntions.circleLine(g.currentLine),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${g.etsMoInfo.getMo}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: g.fontSizeAppbar)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(' ${g.etsMoInfo.getDesc.trim()}',
                        style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Text(' - ${g.etsMoInfo.getQty.toString()} Pcs',
                        style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
