import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tivnqn/connection/sqlApp.dart';
import 'package:tivnqn/connection/sqlEtsDB.dart';
import 'package:tivnqn/connection/sqlProductionDB.dart';
import 'package:tivnqn/model/etsMoQty.dart';
import 'package:tivnqn/model/configs.dart';
import 'package:tivnqn/model/etsMoInfo.dart';
import 'package:tivnqn/model/planning.dart';
import 'package:tivnqn/model/preparation/.chartDataPCutting.dart';
import 'package:tivnqn/model/preparation/chartDataPInspection.dart';
import 'package:tivnqn/model/preparation/chartDataPRelaxation.dart';
import 'package:tivnqn/model/preparation/pCutting.dart';
import 'package:tivnqn/model/preparation/pDispatch.dart';
import 'package:tivnqn/model/preparation/pInspectionFabric.dart';
import 'package:tivnqn/model/preparation/pRelaxationfabricTable.dart';
import 'package:tivnqn/model/sqlT50InspectionData.dart';
import 'package:tivnqn/model/sqlT58InlineData.dart';
import 'package:tivnqn/model/thongbao.dart';

class g {
  static DateTime today = DateTime.now();
  static String title = 'SẢN LƯỢNG & TỈ LỆ LỖI';
  static late String todayString;
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateFormatVi = 'dd/MM/yyyy';
  static int rangeDays = 14;

  static String version = '2.0.0';
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double appBarH = 40;
  static double footerH = 25;
  static double fontSizeAppbar = 20;

  static String ip = '';
  static bool isTVControl = false;
  static bool isTVLine = false;
  static String imgDashboardLink = '';
  static var currencyFormat =
      NumberFormat.currency(locale: "vi_VN", symbol: "đ");
  static int screenType = 1; //1 :chart , 2: name, 3: process
  static String screenMode = 'chartProduction'; // 'chartETS',
  static bool autochangeLine = false;
  static bool isLoading = false;
  static List<int> lines = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  static List<int> lineETS = [3, 8];
  static int currentLine = 0;
  static int currentLineETS = 3;
  static bool selectAllLine = true;
  static String timeType = 'Daily';
  static List<String> timeTypes = ['Daily', 'Weekly', 'Monthly'];
  static var sqlProductionDB = SqlProductionDB();
  static var sqlEtsDB = SqlEtsDB();
  static List<EtsMoQty> etsMoQtys = [];
  static EtsMoInfo etsMoInfo =
      EtsMoInfo(mo: 'ZDCODE', style: 'STYLE_NO', qty: 0, desc: 'XM');
  static String currentMo = '';
  static List<String> etsMOs = [];

  static var sqlApp = SqlApp();
  static List<PCutting> pCuttings = [];
  static List<ChartDataPCutting> chartDataPCuttings = [];
  static List<PDispatch> pDispatchs = [];
  static List<PInspectionFabric> pInspectionFabrics = [];
  static List<PRelaxationFabricTable> pRelaxationFabricTables = [];
  static List<ChartDataPInspection> chartDataPInspection = [];
  static List<ChartDataPRelaxation> chartDataPRelaxation = [];

  static int curentItemNo = 0;
  static List<SqlT59TransInline> sqlT59TransInline = [];
  static List<SqlT58InlineData> sqlT58InlineDataDailysSumProcess = [];
  static List<SqlT58InlineData> sqlT58InlineDataDailysDetailProcess = [];
  static List<SqlT58InlineData> sqlT58InlineDataLastDay = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataDailys = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataWeeklys = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataMonthlys = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataDailysSummaryAll = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataWeeklysSummaryAll = [];
  static List<SqlT50InspectionData> sqlT50InspectionDataMonthlysSummaryAll = [];

  static List<Configs> configs = [];
  static Configs config = Configs();
  List<Map<int, String>> defectCodeNames = [];

  static ValueNotifier<String> reloadType = ValueNotifier('');
  static late Widget chartInspectionDataQty;
  static late Widget chartInspectionDataQtyDefect;
  static late Widget chartInspectionDataRatioDefect;

  //---------------- planning chart
  static bool enablePercentComplete = false;
  static List<Planning> sqlPlanning = [];
  static late ThongBao thongbao;
  static bool showThongBao = false;
}
