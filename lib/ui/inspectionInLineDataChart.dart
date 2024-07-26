import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivnqn/model/sqlT58InlineData.dart';

class InspectionInLineDataChart {
  static var myDataLabelSettings = const DataLabelSettings(
      showZeroValue: false,
      labelAlignment: ChartDataLabelAlignment.middle,
      isVisible: true,
      textStyle: TextStyle(fontSize: 7));
  static Legend myLegend = const Legend(
      itemPadding: 5,
      // height: '40%',
      textStyle: TextStyle(
          fontSize: 7, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.bottom,
      isVisible: false,
      overflowMode: LegendItemOverflowMode.wrap);

  static Widget createChartSummayByProcessLastDay(
      List<SqlT58InlineData> dataInput) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(5),
      backgroundColor: Colors.white,
      legend: myLegend,
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            minimum: 0,
            maximum: 30,
            labelStyle: const TextStyle(fontSize: 12),
            interval: 5)
      ],
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontSize: 10),
        interval: 1.0,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          opposedPosition: false,
          minimum: 0,
          labelStyle: const TextStyle(fontSize: 12),
          interval: 5
          // maximum: 150,
          // interval: 50,
          // labelFormat: '{value}Pcs',
          ),
      series: getSeriesInlineDataByProcessLastDay(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesInlineDataByProcessLastDay(List<SqlT58InlineData> dataInput) {
    return <ChartSeries<SqlT58InlineData, String>>[
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            data.getProcessNo.toString(),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyPass,
        dataLabelSettings: myDataLabelSettings,
        // name: '''初回検品合格数 - SL kiểm  đạt''',
        color: Colors.blueAccent[400],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            data.getProcessNo.toString(),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyNG,
        dataLabelSettings: myDataLabelSettings,
        // name: '補修後検品合格数 - SL kiểm  lỗi',
        color: Colors.redAccent[400],
      ),
      LineSeries<SqlT58InlineData, String>(
          markerSettings: const MarkerSettings(
              isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (SqlT58InlineData data, _) =>
              data.getProcessNo.toString(),
          yValueMapper: (SqlT58InlineData data, _) =>
              data.getQty != 0 ? data.getQtyNG / data.getQty * 100 : 0,
          dataLabelSettings: myDataLabelSettings,
          // name: '初回不良率 - TL lỗi',
          color: Colors.green,
          width: 2),
    ];
  }

  static Widget createChartDailyDefectQtyDetail(
      List<SqlT58InlineData> dataInput) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(5),
      backgroundColor: Colors.white,
      legend: myLegend,
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            minimum: 0,
            maximum: 30,
            labelIntersectAction: AxisLabelIntersectAction.rotate45
            // interval: 10
            )
      ],
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontSize: 10),
        interval: 1.0,
        labelRotation: 0, //-45,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        labelStyle: const TextStyle(fontSize: 12),
        // maximum: 150,
        // interval: 50,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeriesInlineDataDailyDefectQtyDetail(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesInlineDataDailyDefectQtyDetail(
      List<SqlT58InlineData> dataInput) {
    return <ChartSeries<SqlT58InlineData, String>>[
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupAThongSo,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.blue[100],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupBPhuLieu,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.orange[200],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupCNguyHiem,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.grey[200],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyDefectGroupDVai,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.yellow,
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupELoiMay,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.blue,
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupFNgoaiQuan,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.green[300],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) =>
            data.getQtyDefectGroupGVatLieu,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.pink[300],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyDefectGroupHKhac,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.orange[500],
      ),
    ];
  }

  static Widget createChartDailyQtyPassNgRatio(
      List<SqlT58InlineData> dataInput) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(5),
      backgroundColor: Colors.white,
      legend: myLegend,
      axes: <ChartAxis>[
        NumericAxis(
          opposedPosition: true,
          name: 'yAxis1',
          majorGridLines: const MajorGridLines(width: 0),
          labelFormat: '{value}%',
          minimum: 0,
          maximum: 30,
          // interval: 10
        )
      ],
      primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontSize: 10),
          interval: 1.0,
          labelRotation: 0, // -45,
          majorGridLines: const MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.rotate45),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        // maximum: 150,
        // interval: 50,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeriesDailyQtyPassNgRatio(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesDailyQtyPassNgRatio(List<SqlT58InlineData> dataInput) {
    return <ChartSeries<SqlT58InlineData, String>>[
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyPass,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.blueAccent[400],
      ),
      StackedColumnSeries<SqlT58InlineData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) => data.getQtyNG,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.red,
      ),
      LineSeries<SqlT58InlineData, String>(
        markerSettings:
            const MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
        dataSource: dataInput,
        yAxisName: 'yAxis1',
        xValueMapper: (SqlT58InlineData data, _) =>
            DateFormat.Md('vi').format(data.getInspectionDate),
        yValueMapper: (SqlT58InlineData data, _) => double.parse(
            (data.getQtyNG / data.getQty * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.green,
      ),
    ];
  }
}
