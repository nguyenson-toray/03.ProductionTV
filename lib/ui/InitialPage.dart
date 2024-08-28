import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tivnqn/global.dart';
import 'dart:async';
import 'package:flu_wake_lock/flu_wake_lock.dart';
import 'package:tivnqn/model/preparation/.chartDataPCutting.dart';
import 'package:tivnqn/model/preparation/chartDataPInspection.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/ui/dashboardDataInline.dart';
import 'package:tivnqn/ui/dashboardProduction.dart';
import 'package:tivnqn/ui/dashboardImage.dart';
import 'package:tivnqn/ui/dashboardPlanning.dart';
import 'package:tivnqn/ui/dashboardPreparation.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:io' show Platform, Socket;

class InitialPgae extends StatefulWidget {
  const InitialPgae({super.key});

  @override
  State<InitialPgae> createState() => _InitialPgaeState();
}

class _InitialPgaeState extends State<InitialPgae> {
  bool isShowDataInline = true;
  bool isConnectedSqlAppTiqn = false;
  bool isLoading = true;
  bool isWiFiEnabled = false;
  String textLoading = "";
  FluWakeLock fluWakeLock = FluWakeLock();
  String imgLinkOrg = '';
  int count = 0;
  @override
  initState() {
    // TODO: implement initState
    fluWakeLock.enable();
    Future.delayed(Durations.medium1).then(
      (value) {
        g.screenWidth = MediaQuery.of(context).size.width;
        g.screenHeight = MediaQuery.of(context).size.height;
        print('screen size : ${g.screenWidth} x ${g.screenHeight}');
        checkNetworkAndDB();
      },
    );

    super.initState();
  }

  Future<void> checkNetworkAndDB() async {
    print('checkNetworkAndDB');
    bool connectionToDB = false;
    const String ipDB = '10.0.1.4';
    do {
      setState(() {
        count++;
      });

      isWiFiEnabled = await WiFiForIoTPlugin.isEnabled();
      print('isWiFiEnabled: $isWiFiEnabled');
      if (!isWiFiEnabled) {
        await WiFiForIoTPlugin.setEnabled(true);
        connectToWiFi('Office', 'Tiqn123!');
        await Future.delayed(const Duration(seconds: 3));
      }
      g.ip = (await NetworkInfo().getWifiIP())!;
      if (kDebugMode) {
        setState(() {
          g.ip = '10.0.1.51';
        });
      }
      connectionToDB = await checkConnectionToDB(ipDB);
      await Future.delayed(const Duration(seconds: 1));
    } while (!connectionToDB && count <= 3);
    if (count > 3) {
      setState(() {
        textLoading =
            "Có lỗi xảy ra ! Bấm phím BACK trên điều khiển từ xa để tắt ứng dụng & mở lại !";
      });

      return;
    }
    print('g.ip : ${g.ip} ');
    isConnectedSqlAppTiqn = await g.sqlApp.initConnection();
    if (isConnectedSqlAppTiqn) {
      g.configs = await g.sqlApp.sellectConfigs();
      for (var element in g.configs) {
        if (g.ip == element.getIp) {
          g.config = element;
          imgLinkOrg = element.getImageLink;
        }
      }
      setState(() {
        textLoading = '';
        Future.delayed(const Duration(milliseconds: 200)).then((val) {
          loadDataGoToNextPage();
          return;
        });
      });
    } else {
      setState(() {
        textLoading =
            "Có lỗi xảy ra ! Bấm phím BACK trên điều khiển từ xa để tắt ứng dụng & mở lại !";
      });
    }
  }

  Future<bool> checkConnectionToDB(String ipDB) async {
    bool connectionToDB = false;
    const int port = 1433;
    try {
      await Socket.connect(ipDB, port, timeout: const Duration(seconds: 3))
          .then((socket) {
        // do what need to be done
        print('Connection to : $ipDB:$port OK');
        connectionToDB = true;
        // Don't forget to close socket
        socket.destroy();
      });
    } catch (e) {
      print('checkConnectionToDB exception: $e');
    }

    return connectionToDB;
  }

  void connectToWiFi(String ssid, String password) async {
    await WiFiForIoTPlugin.connect(
      ssid,
      password: password,
      security: NetworkSecurity.WPA,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: count <= 3 ? Colors.white : Colors.black26,
            width: g.screenWidth,
            height: g.screenHeight,
            child: SizedBox(
              // width: 100,
              height: count > 3 ? 500 : 250,
              child: count > 3
                  ? Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Image.asset('assets/remotetv.png'),
                        ),
                        Text(
                          textLoading,
                          style: const TextStyle(fontSize: 22, color: Colors.yellow),
                        )
                      ],
                    )
                  : Column(children: [
                      SizedBox(
                          width: 200, child: Image.asset('assets/logo.png')),
                      SizedBox(
                          width: 150, child: Image.asset('assets/loading.gif')),
                    ]),
            )));
  }

  Future<void> loadDataGoToNextPage() async {
    String appBarTitle = '';
    await g.sqlProductionDB.initConnection();
    switch (g.config.getSection) {
      case 'line1':
      case 'line2':
      case 'line3':
      case 'line4':
      case 'line5':
      case 'line6':
      case 'line7':
      case 'line8':
      case 'line9':
      case 'line10':
      case 'line11':
      case 'line12':
        {
          print('-------line--------');

          g.thongbao = await g.sqlApp.sellectThongBao();
          g.isTVLine = true;
          g.selectAllLine = false;
          g.rangeDays = g.config.getProductionChartRangeDay;
          g.currentLine =
              int.parse(g.config.getSection.toString().split('line').last);

          if (g.config.getEtsMO != 'mo') {
            g.currentMo = g.config.getEtsMO;
            await MyFuntions.sellectDataETS(g.currentMo);
          }

          if (isShowDataInline) {
            bool loaded = false;
            do {
              print('*********0000000000000000000000*******loaded: $loaded');
              loaded = await MyFuntions.selectTInlineData();
            } while (!loaded);
            print('*********111111111111*******loaded: $loaded');
            goToDashboardDataInline();
            // g.sqlT50InspectionDataDailys = await g.sqlProductionDB
            //     .selectSqlT50InspectionData(
            //         g.currentLine, g.rangeDays, g.timeTypes[0], 0);
          } else {
            MyFuntions.selectT50InspectionDataOneByOne(0)
                .then((value) => goDashboardProductionNew()); //no summary
          }
        }

        break;
      case 'control1':
        {
          g.currentLine = 0;
          g.autochangeLine = false;

          g.isTVLine = false;
          g.isTVControl = true;
          g.selectAllLine = true;
          g.rangeDays = 7;
          MyFuntions.selectT50InspectionDataOneByOne(1)
              .then((value) => goDashboardProductionNew()); //  summary
        }
        break;
      case 'control2':
        {
          g.currentLine = 1;
          g.autochangeLine = true;
          g.isTVLine = false;
          g.isTVControl = true;
          g.selectAllLine = false;
          g.rangeDays = 7;
          MyFuntions.selectT50InspectionDataOneByOne(0)
              .then((value) => goDashboardProductionNew()); // no summary
        }
        break;
      case 'preparation1':
        {
          g.title = 'INSPECTION & REAXATION FABRIC';
          g.pRelaxationFabricTables =
              await g.sqlApp.sellectPRelaxationFabricTable();

          for (var element in g.pInspectionFabrics) {
            var a = element.planQty as num;
            var b = element.actualQty as num;
            ChartDataPInspection temp = ChartDataPInspection(
                name:
                    '${element.kindOfFabric} - ${element.customer}\nArtNo: ${element.artNo} - LotNo: ${element.lotNo}\n🎨 ${element.color} #️⃣ Process:${element.actualQty}/${element.planQty}',
                actual: element.actualQty as num,
                remain: a - b);
            g.chartDataPInspection.add(temp);
          }

          goToPreparation();
        }
        break;
      case 'preparation2':
        {
          g.title = 'CUTTING';
          g.pCuttings = await g.sqlApp.sellectPCutting();
          for (var element in g.pCuttings) {
            var a = element.planQty as num;
            var b = element.actualQty as num;
            ChartDataPCutting temp = ChartDataPCutting(
                name:
                    'Line: ${element.line} - ${element.band} - Style:${element.styleNo} - Color: ${element.color} - Size: ${element.size} #️⃣ Process: ${element.actualQty}/${element.planQty}',
                actual: element.actualQty as num,
                remain: a - b);
            g.chartDataPCuttings.add(temp);
          }
          goToPreparation();
        }
        break;

      case 'sample':
        {
          appBarTitle = 'SAMPLE PLANNING';
          goToDashboardImage(appBarTitle, imgLinkOrg);
        }
        break;

      case 'planning':
        {
          appBarTitle = 'PRODUCTION PLANNING';
          if (g.config.getImageLink.toString().contains('https://')) {
            goToDashboardImage(appBarTitle, imgLinkOrg);
          } else {
            g.sqlPlanning = await g.sqlApp.getPlanning();
            // Loader.hide();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const DashboardPlanning()),
            );
          }
        }
      default:
        {
          // control1 summary
          g.currentLine = 0;
          g.autochangeLine = false;
          g.isTVLine = false;
          g.isTVControl = true;
          g.selectAllLine = true;
          g.rangeDays = 7;
          MyFuntions.selectT50InspectionDataOneByOne(1)
              .then((value) => goDashboardProductionNew()); //  summary
        }
    }
  }

  void goToPreparation() {
    print("------------------> goToPreparation");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPreparation()),
    );
  }

  void goToDashboardImage(String title, String imgLinkOrg) {
    print("------------------> goToDashboardImage");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardImage(
              title: title,
              linkImageDirectly: MyFuntions.getLinkImage(imgLinkOrg))),
    );
  }

  Future<void> goDashboardProductionNew() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardProduction()),
    );
  }

  Future<void> goToDashboardDataInline() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardDataInline()),
    );
  }
}
