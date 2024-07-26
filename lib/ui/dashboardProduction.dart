import 'dart:async';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/ui/announcement.dart';
import 'package:tivnqn/ui/dashboardETS.dart';
import 'package:tivnqn/ui/inspectionEndLineDataChart.dart';

class DashboardProduction extends StatefulWidget {
  const DashboardProduction({super.key});

  @override
  State<DashboardProduction> createState() => _DashboardProductionState();
}

class _DashboardProductionState extends State<DashboardProduction> {
  double explainColorH = 20;
  double chartH = 220;
  // double chartW = 300;
  int playMinute = 5;
  RadioGroupController radioLineController = RadioGroupController();
  RadioGroupController radioInspectionTypeController = RadioGroupController();
  ChartSeriesController? chartSeriesController;
  final Cron cronGotoETS = Cron();
  late Timer myTimer;
  @override
  void initState() {
    // TODO: implement initState
    DateTime chartBeginTime =
        DateTime.parse("${g.todayString} " + g.config.getProductionChartBegin);
    DateTime chartEndTime = chartBeginTime
        .add(Duration(minutes: g.config.getProductionChartDurationMinute));
    chartSeriesController?.updateDataSource(
        updatedDataIndexes: List<int>.generate(
            g.sqlT50InspectionDataDailys.length, (i) => i + 1));

    if (g.isTVLine &&
        g.config.getEtsMO.toString().length == 10 &&
        DateTime.now().isAfter(chartEndTime)) {
      Future.delayed(Durations.short1)
          .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardETS()),
              ));
    }

    if (g.autochangeLine) {
      Timer.periodic(Duration(minutes: playMinute), (timer) async {
        increaseLineNumber();
      });
    }
    myTimer = Timer.periodic(Duration(seconds: g.config.getReloadSeconds),
        (timer) async {
      g.configs = await g.sqlApp.sellectConfigs();
      if (g.isTVLine) {
        if (g.config.getEtsMO.toString().length == 10 &&
            DateTime.now().isAfter(chartEndTime)) {
          await MyFuntions.sellectDataETS(g.currentMo);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardETS()),
          );
        } else {
          g.thongbao = await g.sqlApp.sellectThongBao();
          if (MyFuntions.checkThongBao()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Announcement()),
            );
          }
        }
      }

      setState(() {
        reloadDataUI();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myTimer.cancel();
    cronGotoETS.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            width: g.screenWidth - explainColorH,
            height: explainColorH,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: Colors.blueAccent[400], child: const Text('Số lượng đạt')),
                Container(
                    color: Colors.redAccent[400], child: const Text('Số lượng lỗi')),
                Container(color: Colors.tealAccent, child: const Text('Thông số')),
                Container(color: Colors.orangeAccent, child: const Text('Phụ kiện')),
                Container(color: Colors.grey, child: const Text('Nguy hiểm')),
                Container(color: Colors.yellowAccent, child: const Text('Vải')),
                Container(
                    color: Colors.lightBlueAccent, child: const Text('Lỗi may')),
                Container(
                    color: Colors.greenAccent, child: const Text('Ngoại quan, TP')),
                Container(color: Colors.cyanAccent, child: const Text('Phụ liệu')),
                Container(color: Colors.purpleAccent, child: const Text('Khác')),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            alignment: Alignment.center,
            width: g.screenWidth - explainColorH,
            height: explainColorH,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: (g.screenWidth - explainColorH) / 3,
                  alignment: Alignment.center,
                  child: Text(
                    "Tổng số lượng đạt, lỗi & tỉ lệ lỗi chung".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: (g.screenWidth - explainColorH) / 3,
                  alignment: Alignment.center,
                  child: Text(
                    "Số lượng các nhóm lỗi".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                g.isTVLine
                    ? Container()
                    : Container(
                        width: (g.screenWidth - explainColorH) / 3,
                        alignment: Alignment.center,
                        child: Text(
                          "Tỉ lệ các nhóm lỗi".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
              ],
            ),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'KQ kiểm sơ cấp',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  g.isTVLine
                      ? Container()
                      : const RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'KQ kiểm thứ cấp',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.black12,
                  width: g.screenWidth - explainColorH,
                  height: g.screenHeight - g.appBarH - explainColorH * 2 - 16,
                  padding: const EdgeInsets.all(2),
                  // color: Colors.greenAccent,
                  child: MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 0,
                      padding: const EdgeInsets.all(0),
                      itemCount: g.isTVLine ? 2 : 6,
                      crossAxisCount: g.isTVLine ? 2 : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.all(1),
                            height: g.isTVLine ? chartH * 2 : chartH,
                            child: createUIChartAtIndex(
                                index, g.timeType, g.selectAllLine));
                      })),
            ],
          ),
        ],
      ),
    );
  }

  appBar() {
    return AppBar(
        toolbarHeight: g.appBarH,
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 6.0,
        leadingWidth: 95,
        leading: MyFuntions.logo(),
        title: g.isTVLine
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: MyFuntions.circleLine(g.currentLine),
              )
            : Container(),
        actions: g.isTVControl
            ? controlFuntion()
            : [
                MyFuntions.clockAppBar(context),
              ]);
  }

  Widget createUIChartAtIndex(int index, String timeType, bool sellectAllLine) {
    Widget result = Container();
    int inspectionType = 1;
    if (index >= 3) inspectionType = 2;
    switch (index) {
      case 0:
      case 3:
        switch (timeType) {
          case 'Daily':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataDailysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    true)
                : result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataDailys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    true);

            break;
          case 'Weekly':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataWeeklysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataWeeklys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          case 'Monthly':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataMonthlysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyQty(
                    g.sqlT50InspectionDataMonthlys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          default:
        }

        break;
      case 1:
      case 4:
        switch (timeType) {
          case 'Daily':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataDailysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    true)
                : result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataDailys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    true);
            break;
          case 'Weekly':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataWeeklysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataWeeklys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          case 'Monthly':
            sellectAllLine
                ? result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataMonthlysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyDefectQty(
                    g.sqlT50InspectionDataMonthlys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          default:
        }

        break;
      case 2:
      case 5:
        switch (timeType) {
          case 'Daily':
            g.selectAllLine
                ? result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataDailysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    true)
                : result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataDailys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    true);
            break;
          case 'Weekly':
            g.selectAllLine
                ? result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataWeeklysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataWeeklys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          case 'Monthly':
            g.selectAllLine
                ? result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataMonthlysSummaryAll
                        .where((element) =>
                            element.getInspectionType == inspectionType)
                        .toList(),
                    false)
                : result = InspectionDataChart.createChartDailyDefectRatio(
                    g.sqlT50InspectionDataMonthlys
                        .where((element) =>
                            element.getInspectionType == inspectionType &&
                            element.getLine == g.currentLine)
                        .toList(),
                    false);
            break;
          default:
        }

        break;

      default:
        result = Container();
    }
    return result;
  }

  void increaseLineNumber() {
    g.currentLine++;
    if (g.currentLine > g.lines.last) {
      g.currentLine = 1;
    }
    radioLineController.selectAt(g.lines.indexOf(g.currentLine));
    reloadDataUI();
  }

  Future<void> reloadDataUI() async {
    print('************** reloadDataUI - line ${g.currentLine}');
    MyFuntions.selectT50InspectionDataOneByOne(g.isTVLine ? 0 : 1);
    chartSeriesController?.updateDataSource(
        updatedDataIndexes: List<int>.generate(
            g.sqlT50InspectionDataDailys.length, (i) => i + 1));
  }

  List<Widget> controlFuntion() {
    return [
      !g.selectAllLine
          ? RadioGroup(
              onChanged: (value) {
                setState(() {
                  g.currentLine = int.parse(value.toString());
                });
              },
              controller: radioLineController,
              values: g.lines,
              indexOfDefault: g.lines.indexOf(g.currentLine),
              orientation: RadioGroupOrientation.Horizontal,
              decoration: const RadioGroupDecoration(
                spacing: 2.0,
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                activeColor: Colors.white,
              ),
            )
          : Container(),
      RadioGroup(
        onChanged: (value) {
          setState(() {
            g.timeType = value.toString();
          });
        },
        controller: radioInspectionTypeController,
        values: g.timeTypes,
        indexOfDefault: g.timeTypes.indexOf(g.timeType),
        orientation: RadioGroupOrientation.Horizontal,
        decoration: const RadioGroupDecoration(
          spacing: 2.0,
          labelStyle: TextStyle(color: Colors.black, fontSize: 8),
          activeColor: Colors.amber,
        ),
      ),
      Row(
        children: [
          Checkbox(
            value: g.selectAllLine,
            onChanged: (value) {
              setState(() {
                g.autochangeLine = !g.autochangeLine;
                g.selectAllLine = !g.selectAllLine;
                if (g.currentLine == 0) g.currentLine = 1;
              });
            },
          ),
          const Text(
            '''All
Line ''',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ];
  }
}
