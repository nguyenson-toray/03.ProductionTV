import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tivnqn/global.dart';
import 'package:cron/cron.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flu_wake_lock/flu_wake_lock.dart';
import 'package:tivnqn/model/preparation/.chartDataPCutting.dart';
import 'package:tivnqn/model/preparation/chartDataPInspection.dart';
import 'package:tivnqn/model/preparation/chartDataPRelaxation.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/ui/announcement.dart';
import 'package:tivnqn/ui/dashboardProduction.dart';
import 'package:tivnqn/ui/dashboardImage.dart';
import 'package:tivnqn/ui/dashboardPlanning.dart';
import 'package:tivnqn/ui/dashboardPreparation.dart';
import 'package:tivnqn/ui/dashboardETS.dart';
import 'package:youtube_player_flutter_quill/youtube_player_flutter_quill.dart';

class InitialPgae extends StatefulWidget {
  const InitialPgae({super.key});

  @override
  State<InitialPgae> createState() => _InitialPgaeState();
}

class _InitialPgaeState extends State<InitialPgae> {
  bool isConnectedSqlAppTiqn = false;
  bool isLoading = true;
  String textLoading = "Load config !";
  FluWakeLock fluWakeLock = FluWakeLock();
  late YoutubePlayerController controller;
  var cron = new Cron();
  bool isPlaying = false;
  bool isPlayed = false;
  String linkDoExercise =
      'https://www.youtube.com/watch?v=Sv7bkD9t9zU&t=8s&ab_channel=%E6%9D%B1%E6%80%A5%E5%BB%BA%E8%A8%AD%E5%85%AC%E5%BC%8F';

  String videoID = '';
  bool playerIsReady = false;
  late DateTime exceriseBegin;
  late DateTime currentTime;
  Duration seekTime = Duration(milliseconds: 0);
  late int hour;
  late int minute;
  String hourString = "07";
  String minuteString = "45";
  bool showVideo = false;
  String imgLinkOrg = '';
  @override
  initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 300), () async {
      g.screenWidth = MediaQuery.of(context).size.width;
      g.screenHeight = MediaQuery.of(context).size.height;
      print('screen size : ${g.screenWidth} x ${g.screenHeight}');
    });
    fluWakeLock.enable();

    initSQLConfigsDoExcerise();

    videoID = YoutubePlayer.convertUrlToId(linkDoExercise)!;
    controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        hideControls: true,
        loop: false,
        mute: kDebugMode ? false : true,
        autoPlay: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void checkAndPlay() async {
    g.sqlApp.sellectConfigs().then((value) => {
          if (value[0].getDoExercise == 1)
            {
              setState(() {
                controller.play();
                isPlaying = true;
              })
            },
        });
  }

  Future<void> initSQLConfigsDoExcerise() async {
    g.ip = (await NetworkInfo().getWifiIP())!;
    if (kDebugMode) {
      setState(() {
        g.ip = '192.168.1.70';
      });
    }
    isConnectedSqlAppTiqn = await g.sqlApp.initConnection();
    isLoading = false;
    if (isConnectedSqlAppTiqn) {
      g.configs = await g.sqlApp.sellectConfigs();
      g.configs.forEach((element) {
        if (g.ip == element.getIp) {
          g.config = element;
          imgLinkOrg = element.getImageLink;
        }
      });
      setState(() {
        isLoading = false;
        textLoading = '';
        exceriseBegin = DateTime.parse("${g.todayString} " + "07:45:00");
        print('exceriseBegin :' + exceriseBegin.toString());
        if (g.config.getDoExercise == 0 ||
            DateTime.now().isAfter(exceriseBegin)) {
          Future.delayed(const Duration(milliseconds: 200)).then((val) {
            loadDataGoToNextPage();
            return;
          });
        } else {
          showVideo = true;
          Timer.periodic(Duration(milliseconds: 200), (timer) {
            if (!isPlaying && playerIsReady) checkAndPlay();
            if (isPlaying) {
              timer.cancel();
            }
          });
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 10), () {
        setState(() {
          textLoading =
              "Có lỗi xảy ra ! Bấm phím BACK trên điều khiển từ xa để tắt ứng dụng & mở lại !";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          showVideo
              ? YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.tealAccent,
                  ),
                  onReady: () {
                    print('Player is ready.');
                    if (DateTime.now().isAfter(exceriseBegin)) {
                      loadDataGoToNextPage();
                    } else
                      setState(() {
                        playerIsReady = true;
                      });
                  },
                  onEnded: (metaData) {
                    setState(() {
                      isPlayed = true;
                    });
                    loadDataGoToNextPage();
                  },
                )
              : Container(),
          isLoading ? MyFuntions.showLoading() : Container(),
        ],
      ),
    );
  }

  Future<void> loadDataGoToNextPage() async {
    setState(() {
      isLoading = true;
    });

    String appBarTitle = '';
    await g.sqlProductionDB.initConnection();
    await g.sqlEtsDB.initConnection();
    print('g.ip : ${g.ip} ');

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
          if (g.config.getAnnouncementOnly == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Announcement()),
            );
            break;
          }
          MyFuntions.selectT50InspectionDataOneByOne(0)
              .then((value) => goDashboardProductionNew()); //no summary
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
      case 'lineControl3':
        {
          // ETS
          var section = g.configs
              .where((element) => element.getEtsMO != 'no')
              .first
              .getSection;

          g.configs.forEach((element) {
            if (element.getEtsMO != 'no') {
              g.lineETS.add(int.parse(section.split('line').last));
              g.etsMOs.add(element.getEtsMO);
            }
          });
          g.currentMo = g.etsMOs.first;
          g.currentLine = g.lineETS.first;
          await MyFuntions.sellectDataETS(g.currentMo);
          g.isTVControl = true;
          g.isTVLine = false;
          g.autochangeLine = true;
          goDashboardETS();
        }

        break;
      case 'preparation1':
        {
          g.title = 'INSPECTION & REAXATION FABRIC';
          g.pRelaxationFabricTables =
              await g.sqlApp.sellectPRelaxationFabricTable();

          g.pInspectionFabrics.forEach((element) {
            var a = element.planQty as num;
            var b = element.actualQty as num;
            ChartDataPInspection temp = ChartDataPInspection(
                name:
                    '${element.kindOfFabric} - ${element.customer}\nArtNo: ${element.artNo} - LotNo: ${element.lotNo}\n🎨 ${element.color} #️⃣ Process:${element.actualQty}/${element.planQty}',
                actual: element.actualQty as num,
                remain: a - b);
            g.chartDataPInspection.add(temp);
          });

          goToPreparation();
        }
        break;
      case 'preparation2':
        {
          g.title = 'CUTTING';
          g.pCuttings = await g.sqlApp.sellectPCutting();
          g.pCuttings.forEach((element) {
            var a = element.planQty as num;
            var b = element.actualQty as num;
            ChartDataPCutting temp = ChartDataPCutting(
                name:
                    'Line: ${element.line} - ${element.band} - Style:${element.styleNo} - Color: ${element.color} - Size: ${element.size} #️⃣ Process: ${element.actualQty}/${element.planQty}',
                actual: element.actualQty as num,
                remain: a - b);
            g.chartDataPCuttings.add(temp);
          });
          goToPreparation();
        }
        break;
      case 'preparation3':
        {
          g.title = 'DISPATCH TO SEWING LINE PLAN';
          g.pDispatchs = await g.sqlApp.sellectPDispatch();
          goToPreparation();
        }
        break;
      case 'sample':
        {
          appBarTitle = 'SAMPLE PLANNING';
          goToDashboardImage(appBarTitle, imgLinkOrg);
        }
        break;
      case 'qc':
        {
          appBarTitle = 'QC';
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
              MaterialPageRoute(builder: (context) => DashboardPlanning()),
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
      MaterialPageRoute(builder: (context) => DashboardPreparation()),
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
      MaterialPageRoute(builder: (context) => DashboardProduction()),
    );
  }

  void goDashboardETS() async {
    print("------------------> goDashboardETS");
    await MyFuntions.sellectDataETS(g.currentMo);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardETS()),
    );
  }
}
