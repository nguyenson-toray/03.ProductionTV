import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:tivnqn/model/sqlT58InlineData.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/ui/inspectionInLineDataChart.dart';

class DashboardDataInline extends StatefulWidget {
  const DashboardDataInline({super.key});

  @override
  State<DashboardDataInline> createState() => _DashboardDataInlineState();
}

class _DashboardDataInlineState extends State<DashboardDataInline> {
  late DateTime lastDay;
  int curentProcess = 0, maxProcess = 0;
  List<SqlT58InlineData> dataDetailByProcess = [];
  List<SqlT59TransInline> sqlT59TransInline = [];
  @override
  void initState() {
    // TODO: implement initState
    lastDay = g.sqlT58InlineDataDailysSumProcess.last.getInspectionDate;
    dataDetailByProcess = filterDataByCurrentProcess(curentProcess);
    maxProcess = g.sqlT58InlineDataDailysDetailProcess.last.getProcessNo;
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) async {
      g.configs = await g.sqlApp.sellectConfigs();
      setState(() {
        MyFuntions.selectTInlineData();
      });
    });
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) async {
      setState(() {
        curentProcess == maxProcess ? curentProcess = 0 : curentProcess++;
        dataDetailByProcess = filterDataByCurrentProcess(curentProcess);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: g.screenWidth / 2 - 4 - 40,
                      height: 25,
                      child: Center(
                        child: Text(
                            'Tổng hợp số lượng ĐẠT, LỖI, TỈ LỆ LỖI ngày ${DateFormat.Md('vi').format(lastDay)}'),
                      ),
                    ),
                    Container(
                      width: g.screenWidth / 2 - 4 - 40,
                      height: (g.screenHeight - g.appBarH) / 2 - 30,
                      child: InspectionInLineDataChart
                          .createChartSummayByProcessLastDay(
                              g.sqlT58InlineDataLastDay),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: g.screenWidth / 2 + 40,
                      height: 25,
                      child: Center(
                          child:
                              Text('Danh sách các công đoạn kiểm tra IN-LINE')),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: g.screenWidth / 2 + 40,
                      height: (g.screenHeight - g.appBarH) / 2 - 30,
                      child: MasonryGridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 0,
                          padding: const EdgeInsets.all(0),
                          itemCount: g.sqlT59TransInline.length,
                          crossAxisCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: curentProcess == 0
                                  ? Colors.teal[200]
                                  : curentProcess ==
                                          g.sqlT59TransInline[index].processNo
                                      ? Colors.tealAccent[200]
                                      : Colors.transparent,
                              padding: EdgeInsets.all(1),
                              height: 56,
                              child: Text(
                                  style: TextStyle(fontSize: 9),
                                  '${g.sqlT59TransInline[index].processNo} - ${g.sqlT59TransInline[index].proV}${g.sqlT59TransInline[index].proJ}'),
                            );
                          }),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: Colors.blueAccent[400], child: Text('Số lượng đạt')),
                Container(
                    color: Colors.redAccent[400], child: Text('Số lượng lỗi')),
                Container(color: Colors.blue[100], child: Text('Thông số')),
                Container(color: Colors.orange[200], child: Text('Phụ kiện')),
                Container(color: Colors.grey[200], child: Text('Nguy hiểm')),
                Container(color: Colors.yellow, child: Text('Vải')),
                Container(color: Colors.blue, child: Text('Lỗi may')),
                Container(
                    color: Colors.green[300], child: Text('Ngoại quan, TP')),
                Container(color: Colors.pink[300], child: Text('Phụ liệu')),
                Container(color: Colors.orange[500], child: Text('Khác')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: g.screenWidth / 2 - 4,
                      height: 25,
                      child:
                          Center(child: Text('Chi tiết ĐẠT, LỖI, TỈ LỆ LỖI ')),
                    ),
                    Container(
                      width: g.screenWidth / 2 - 4,
                      height: (g.screenHeight - g.appBarH) / 2 - 45,
                      child: InspectionInLineDataChart
                          .createChartDailyQtyPassNgRatio(dataDetailByProcess),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: g.screenWidth / 2 - 4,
                      height: 25,
                      child: Center(child: Text('Chi tiết số lượng lỗi')),
                    ),
                    Container(
                      width: g.screenWidth / 2 - 4,
                      height: (g.screenHeight - g.appBarH) / 2 - 45,
                      child: InspectionInLineDataChart
                          .createChartDailyDefectQtyDetail(dataDetailByProcess),
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  appBar() {
    return AppBar(
        toolbarHeight: g.appBarH,
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 6.0,
        leadingWidth: 95,
        leading: MyFuntions.logo(),
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyFuntions.circleLine(g.currentLine),
              Text(
                  style: TextStyle(color: Colors.white),
                  'KẾT QUẢ KIỂM IN-LINE từ  ${DateFormat.Md('vi').format(lastDay.subtract(Duration(days: g.rangeDays)))} đến ${DateFormat.Md('vi').format(lastDay)}'),
              Text(curentProcess == 0
                  ? 'Tất cả công đoạn'
                  : 'Công đoạn #$curentProcess')
            ],
          ),
        ),
        // actions: [MyFuntions.clockAppBar(context)]);
        actions: [
          InkWell(
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.orangeAccent,
            ),
            onTap: () {
              setState(() {
                curentProcess == 0
                    ? curentProcess = maxProcess
                    : curentProcess--;
                dataDetailByProcess = filterDataByCurrentProcess(curentProcess);
              });
            },
          ),
          InkWell(
            child: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.orangeAccent,
            ),
            onTap: () {
              setState(() {
                curentProcess == maxProcess
                    ? curentProcess = 0
                    : curentProcess++;
                dataDetailByProcess = filterDataByCurrentProcess(curentProcess);
              });
            },
          )
        ]);
  }

  List<SqlT58InlineData> filterDataByCurrentProcess(int processNo) {
    if (processNo == 0) {
      return g.sqlT58InlineDataDailysSumProcess;
    } else {
      return g.sqlT58InlineDataDailysDetailProcess
          .where((data) => data.getProcessNo == processNo)
          .toList();
    }
  }
}
