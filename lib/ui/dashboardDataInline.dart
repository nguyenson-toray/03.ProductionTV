import 'dart:async';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:text_scroll/text_scroll.dart';
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
  double tileH = 20,
      widgetAW = g.screenWidth * 0.3,
      widgetBW = g.screenWidth * 0.68,
      widgetABH = (g.screenHeight - g.appBarH) - 4;
  TextStyle titleStyle =
      const TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
  List<SqlT58InlineData> dataDetailByProcess = [];
  List<SqlT59TransInline> sqlT59TransInline = [];
  late CommentDataSource commentDataSource;
  late Group1DataSource group1DataSource;
  late Group2DataSource group2DataSource;
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
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Column(
                  children: [
                    Text(
                      'Số lượng ĐẠT, LỖI, TỈ LỆ LỖI ngày ${DateFormat.Md('vi').format(lastDay)} theo công đoạn',
                      style: titleStyle,
                    ),
                    SizedBox(
                      width: widgetAW,
                      height: widgetABH / 3 - 20,
                      child: InspectionInLineDataChart
                          .createChartSummayByProcessLastDay(
                              g.sqlT58InlineDataLastDay),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Số lượng ĐẠT, LỖI, TỈ LỆ LỖI theo ngày ',
                        style: titleStyle,
                      ),
                      Text(
                        curentProcess == 0
                            ? ' - Tất cả CĐ'
                            : ' - công đoạn #$curentProcess',
                        style: titleStyle,
                      )
                    ]),
                    Row(
                      children: [
                        SizedBox(
                          width: widgetBW / 2 + 100,
                          height: widgetABH / 3 - 20,
                          child: InspectionInLineDataChart
                              .createChartDailyQtyPassNgRatio(
                                  dataDetailByProcess),
                        ),
                        SizedBox(
                          width: widgetBW / 2 - 100,
                          height: widgetABH / 3 - 50,
                          child: tableComment(),
                        )
                      ],
                    ),
                  ],
                )
              ]),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widgetAW - 60,
                        child: Center(
                            child: Text('Danh sách các công đoạn',
                                style: titleStyle)),
                      ),
                      SizedBox(
                        width: widgetAW - 60,
                        height: widgetABH / 3 * 2 - 14,
                        child: MasonryGridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 0,
                            padding: const EdgeInsets.all(0),
                            itemCount: g.sqlT59TransInline.length,
                            crossAxisCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: curentProcess == 0
                                    ? Colors.white
                                    : curentProcess ==
                                            g.sqlT59TransInline[index].processNo
                                        ? Colors.grey[300]
                                        : Colors.white,
                                padding: const EdgeInsets.all(2),
                                height: 40,
                                child: Text(
                                    style: const TextStyle(fontSize: 10),
                                    '${g.sqlT59TransInline[index].processNo} : ${g.sqlT59TransInline[index].majorV} ${g.sqlT59TransInline[index].proV}'),
                              );
                            }),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Center(
                            child: Text('Chi tiết lỗi', style: titleStyle)),
                      ),
                      Container(
                        color: Colors.white,
                        width: widgetBW + 75,
                        height: widgetABH / 3 - 11,
                        child: tableGroup1(),
                      ),
                      Container(
                        color: Colors.white,
                        width: widgetBW + 75,
                        height: widgetABH / 3 - 11,
                        child: tableGroup2(),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
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
                  style: const TextStyle(color: Colors.white),
                  'KẾT QUẢ KIỂM IN-LINE từ  ${DateFormat.Md('vi').format(lastDay.subtract(Duration(days: g.rangeDays)))} đến ${DateFormat.Md('vi').format(lastDay)}'),
              Text(curentProcess == 0
                  ? 'Tất cả CĐ in-line'
                  : 'CĐ in-line #$curentProcess')
            ],
          ),
        ),
        // actions: [MyFuntions.clockAppBar(context)]);
        actions: [
          InkWell(
            child: const Icon(
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
            child: const Icon(
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
    print('filterDataByCurrentProcess : $processNo');
    List<SqlT58InlineData> dataCmt = [], filteredData = [];
    int count = 0, index = 0;
    if (processNo == 0) {
      filteredData = g.sqlT58InlineDataDailysSumProcess;
    } else {
      filteredData = g.sqlT58InlineDataDailysDetailProcess
          .where((data) => data.getProcessNo == processNo)
          .toList();
    }
    index = filteredData.length - 1;
    while (index > 0) {
      if (filteredData[index].getX07 != '') {
        dataCmt.add(filteredData[index]);
        count++;
      }
      index--;
    }
    commentDataSource = CommentDataSource(comment: dataCmt);
    group1DataSource = Group1DataSource(group1: filteredData.reversed.toList());
    group2DataSource = Group2DataSource(group2: filteredData.reversed.toList());
    return filteredData;
  }

  Widget tableComment() {
    return SfDataGrid(
      source: commentDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 19,
      shrinkWrapRows: true,
      rowHeight: 20,
      columns: <GridColumn>[
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.auto,
            columnName: 'date',
            label: Container(
                padding: const EdgeInsets.all(1),
                alignment: Alignment.center,
                child: const Text(
                  'Ngày',
                ))),
        GridColumn(
            maximumWidth: 220,
            minimumWidth: 220,
            columnWidthMode: ColumnWidthMode.auto,
            columnName: 'cmt',
            label: Container(
                padding: const EdgeInsets.all(1),
                alignment: Alignment.center,
                child: const Text(
                  'Comment',
                ))),
      ],
    );
  }

  Widget tableGroup1() {
    TextStyle styleHeader = const TextStyle(fontSize: 10);
    return SfDataGrid(
      source: group1DataSource,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 60,
      shrinkWrapRows: true,
      rowHeight: 18,
      columns: <GridColumn>[
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'date',
            label: Container(
                padding: const EdgeInsets.all(1),
                alignment: Alignment.center,
                child: Text(
                  'Ngày',
                  style: styleHeader,
                ))),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'loithongso',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    'Lỗi th.số',
                    style: styleHeader,
                  )),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'lechtraiphai',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    'Lệch T-P',
                    style: styleHeader,
                  )),
            )),
        GridColumn(
            minimumWidth: 60,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'loitinhnang',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    style: styleHeader,
                    'Lỗi tính năng',
                  )),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'daykeo',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Dây kéo',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'nut',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Nút',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'khac',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Khác',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'bavia',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    style: styleHeader,
                    'Bavia',
                  )),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'divat',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    style: styleHeader,
                    'Dị vật',
                  )),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'khacmau',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Khác màu',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'soikhac',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Sợi khác',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 70,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'soivoncuc',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Sợi vón cục',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 50,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'khacd',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: TextScroll(
                      style: styleHeader,
                      'Khác',
                    )),
              ),
            )),
      ],
    );
  }

  Widget tableGroup2() {
    TextStyle styleHeader = const TextStyle(fontSize: 10);
    return SfDataGrid(
      source: group2DataSource,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 60,
      shrinkWrapRows: true,
      rowHeight: 18,
      columns: <GridColumn>[
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'date',
            label: Container(
                padding: const EdgeInsets.all(1),
                alignment: Alignment.center,
                child: Text(
                  'Ngày',
                  style: styleHeader,
                ))),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'may',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    'May',
                    style: styleHeader,
                  )),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'bungsut',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    'Bungsút',
                    style: styleHeader,
                  )),
            )),
        GridColumn(
            maximumWidth: 35,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'lokim',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Lổ kim',
                  )),
            )),
        GridColumn(
            minimumWidth: 45,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'bomuisupmi',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Bỏ mũi/sụp mí',
                  )),
            )),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'van',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Vặn',
                  )),
            )),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'xuot',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Xướt',
                  )),
            )),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'bo',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: TextScroll(
                    style: styleHeader,
                    'Bọ',
                  )),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'sotchi',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Sót chỉ',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 60,
            minimumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'sotphan',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Sót phấn',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'dinhdo',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Dính dơ',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'loiin',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Lỗi in',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'hinhdang',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Hình dáng',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 30,
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'nhan',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Nhăn',
                    )),
              ),
            )),
        GridColumn(
            minimumWidth: 30,
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'canbong',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Cấn bóng',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'le',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Le',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'seam',
            label: Container(
              color: Colors.grey[200],
              child: Transform.rotate(
                angle: -1,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    child: Text(
                      style: styleHeader,
                      'Seam',
                    )),
              ),
            )),
        GridColumn(
            maximumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'thebai',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Thẻ bài',
                  )),
            )),
        GridColumn(
            minimumWidth: 40,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'nhangiat',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Nhãn giặt',
                  )),
            )),
        GridColumn(
            minimumWidth: 30,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            columnName: 'nhanx',
            label: Transform.rotate(
              angle: -1,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  child: Text(
                    style: styleHeader,
                    'Nhãn',
                  )),
            )),
      ],
    );
  }
}

class CommentDataSource extends DataGridSource {
  CommentDataSource({required List<SqlT58InlineData> comment}) {
    _comments = comment
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat.Md('vi').format(e.getInspectionDate)),
              DataGridCell<String>(
                columnName: 'cmt',
                value: e.getX07,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _comments = [];
  @override
  List<DataGridRow> get rows => _comments;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2.0),
        child: Text(
          e.value.toString(),
          style: const TextStyle(fontSize: 10),
        ),
      );
    }).toList());
  }
}

class Group1DataSource extends DataGridSource {
  Group1DataSource({required List<SqlT58InlineData> group1}) {
    _group1s = group1
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat.Md('vi').format(e.getInspectionDate)),
              DataGridCell<int>(
                columnName: 'loithongso',
                value: e.getA01,
              ),
              DataGridCell<int>(
                columnName: 'lechtraiphai',
                value: e.getA02,
              ),
              DataGridCell<int>(
                columnName: 'loitinhnang',
                value: e.getA03,
              ),
              DataGridCell<int>(
                columnName: 'daykeo',
                value: e.getB01,
              ),
              DataGridCell<int>(
                columnName: 'nut',
                value: e.getB02,
              ),
              DataGridCell<int>(
                columnName: 'khac',
                value: e.getB03,
              ),
              DataGridCell<int>(
                columnName: 'bavia',
                value: e.getC01,
              ),
              DataGridCell<int>(
                columnName: 'divat',
                value: e.getC02,
              ),
              DataGridCell<int>(
                columnName: 'khacmau',
                value: e.getD01,
              ),
              DataGridCell<int>(
                columnName: 'soikhac',
                value: e.getD02,
              ),
              DataGridCell<int>(
                columnName: 'soivoncuc',
                value: e.getD03,
              ),
              DataGridCell<int>(
                columnName: 'khacd',
                value: e.getD04,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _group1s = [];
  @override
  List<DataGridRow> get rows => _group1s;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2.0),
        child: Text(
          e.value.toString() != '0' ? e.value.toString() : '-',
          style: TextStyle(
              fontWeight: e.value.toString().length > 2
                  ? FontWeight.normal
                  : e.value.toString() != '0'
                      ? FontWeight.bold
                      : FontWeight.normal,
              fontSize: 12,
              color: e.value.toString().length > 2
                  ? Colors.black
                  : (e.value.toString() == '1' ||
                          e.value.toString() == '2' ||
                          e.value.toString() == '0')
                      ? Colors.black
                      : Colors.red),
        ),
      );
    }).toList());
  }
}

class Group2DataSource extends DataGridSource {
  Group2DataSource({required List<SqlT58InlineData> group2}) {
    _group2s = group2
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat.Md('vi').format(e.getInspectionDate)),
              DataGridCell<int>(
                columnName: 'may',
                value: e.getE01,
              ),
              DataGridCell<int>(
                columnName: 'bungsut',
                value: e.getE02,
              ),
              DataGridCell<int>(
                columnName: 'lokim',
                value: e.getE03,
              ),
              DataGridCell<int>(
                columnName: 'bomuisupmi',
                value: e.getE04,
              ),
              DataGridCell<int>(
                columnName: 'van',
                value: e.getE05,
              ),
              DataGridCell<int>(
                columnName: 'xuot',
                value: e.getE06,
              ),
              DataGridCell<int>(
                columnName: 'bo',
                value: e.getE07,
              ),
              DataGridCell<int>(
                columnName: 'sotchi',
                value: e.getF01,
              ),
              DataGridCell<int>(
                columnName: 'sotphan',
                value: e.getF02,
              ),
              DataGridCell<int>(
                columnName: 'dinhdo',
                value: e.getF03,
              ),
              DataGridCell<int>(
                columnName: 'loiin',
                value: e.getF04,
              ),
              DataGridCell<int>(
                columnName: 'hinhdang',
                value: e.getF05,
              ),
              DataGridCell<int>(
                columnName: 'nhan',
                value: e.getF06,
              ),
              DataGridCell<int>(
                columnName: 'canbong',
                value: e.getF07,
              ),
              DataGridCell<int>(
                columnName: 'le',
                value: e.getF08,
              ),
              DataGridCell<int>(
                columnName: 'seam',
                value: e.getF09,
              ),
              DataGridCell<int>(
                columnName: 'thebai',
                value: e.getG01,
              ),
              DataGridCell<int>(
                columnName: 'nhangiat',
                value: e.getG02,
              ),
              DataGridCell<int>(
                columnName: 'nhanx',
                value: e.getG03,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _group2s = [];
  @override
  List<DataGridRow> get rows => _group2s;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2.0),
        child: Text(
          e.value.toString() != '0' ? e.value.toString() : '-',
          style: TextStyle(
              fontWeight: e.value.toString().length > 2
                  ? FontWeight.normal
                  : e.value.toString() != '0'
                      ? FontWeight.bold
                      : FontWeight.normal,
              fontSize: 12,
              color: e.value.toString().length > 2
                  ? Colors.black
                  : (e.value.toString() == '1' ||
                          e.value.toString() == '2' ||
                          e.value.toString() == '0')
                      ? Colors.black
                      : Colors.red),
        ),
      );
    }).toList());
  }
}
