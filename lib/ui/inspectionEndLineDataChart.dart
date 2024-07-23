import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivnqn/model/sqlT50InspectionData.dart';

class InspectionDataChart {
  static var myDataLabelSettings = const DataLabelSettings(
    showZeroValue: false,
    labelAlignment: ChartDataLabelAlignment.middle,
    isVisible: true,
    // textStyle: TextStyle(fontSize: 8)
  );
  static Legend myLegend = const Legend(
      itemPadding: 5,
      // height: '40%',
      textStyle: TextStyle(
          fontSize: 8, fontWeight: FontWeight.normal, color: Colors.black),
      position: LegendPosition.bottom,
      isVisible: false,
      overflowMode: LegendItemOverflowMode.wrap);

  static Widget createChartDailyQty(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
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
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        // maximum: 150,
        // interval: 50,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeriesInspectionDataDaily(dataInput, isDaily),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesInspectionDataDaily(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
    return <ChartSeries<SqlT50InspectionData, String>>[
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyPass,
        dataLabelSettings: myDataLabelSettings,
        // name: '''初回検品合格数 - SL kiểm  đạt''',
        color: Colors.blueAccent[400],
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyNG,
        dataLabelSettings: myDataLabelSettings,
        // name: '補修後検品合格数 - SL kiểm  lỗi',
        color: Colors.redAccent[400],
      ),
      LineSeries<SqlT50InspectionData, String>(
          markerSettings: const MarkerSettings(
              isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (SqlT50InspectionData data, _) => isDaily
              ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
              : data.getTimeType,
          yValueMapper: (SqlT50InspectionData data, _) =>
              data.getRatioDefectAll,
          dataLabelSettings: myDataLabelSettings,
          // name: '初回不良率 - TL lỗi',
          color: Colors.green,
          width: 2),
    ];
  }

  static Widget createChartDailyDefectQty(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
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
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        // maximum: 150,
        // interval: 50,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeriesInspectionDataDailyDefectQty(dataInput, isDaily),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesInspectionDataDailyDefectQty(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
    return <ChartSeries<SqlT50InspectionData, String>>[
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupA,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.tealAccent,
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
          dataSource: dataInput,
          xValueMapper: (SqlT50InspectionData data, _) => isDaily
              ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
              : data.getTimeType,
          yValueMapper: (SqlT50InspectionData data, _) =>
              data.getQtyDefectGroupB,
          dataLabelSettings: myDataLabelSettings,
          color: Colors.orangeAccent),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupC,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.grey,
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
          dataSource: dataInput,
          xValueMapper: (SqlT50InspectionData data, _) => isDaily
              ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
              : data.getTimeType,
          yValueMapper: (SqlT50InspectionData data, _) =>
              data.getQtyDefectGroupD,
          dataLabelSettings: myDataLabelSettings,
          color: Colors.yellowAccent),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupE,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.lightBlueAccent,
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupF,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.greenAccent,
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupG,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.cyanAccent,
      ),
      StackedColumnSeries<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => data.getQtyDefectGroupH,
        dataLabelSettings: myDataLabelSettings,
        color: Colors.purpleAccent,
      )
    ];
  }

  static Widget createChartDailyDefectRatio(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
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
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        // maximum: 150,
        // interval: 50,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeriesInspectionDataDailyDefectRatio(dataInput, isDaily),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static getSeriesInspectionDataDailyDefectRatio(
      List<SqlT50InspectionData> dataInput, bool isDaily) {
    return <ChartSeries<SqlT50InspectionData, String>>[
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupA / data.getQtyNG * 100).toStringAsFixed(1)),
        // .toStringAsFixed(1),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.tealAccent,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupB / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.orangeAccent[400],
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupC / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.grey,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupD / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.yellowAccent,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupE / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.lightBlueAccent,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupF / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.greenAccent,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupG / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.cyanAccent,
      ),
      StackedColumn100Series<SqlT50InspectionData, String>(
        dataSource: dataInput,
        xValueMapper: (SqlT50InspectionData data, _) => isDaily
            ? DateFormat.Md('vi').format(DateTime.parse(data.getTimeType))
            : data.getTimeType,
        yValueMapper: (SqlT50InspectionData data, _) => double.parse(
            (data.getQtyDefectGroupH / data.getQtyNG * 100).toStringAsFixed(1)),
        dataLabelSettings: myDataLabelSettings,
        color: Colors.purpleAccent,
      )
    ];
  }
}
