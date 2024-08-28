import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tivnqn/global.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tivnqn/model/sqlT58InlineData.dart';

class MyFuntions {
  static int setLineFollowIP(String ip) {
    int line = 1;
    switch (ip) {
      case '192.168.1.71':
        {
          line = 1;
        }
        break;
      case '192.168.1.72':
        {
          line = 2;
        }
        break;
      case '192.168.1.73':
        {
          line = 3;
        }
        break;
      case '192.168.1.74':
        {
          line = 4;
        }
        break;
      case '192.168.1.75':
        {
          line = 5;
        }
        break;
      case '192.168.1.76':
        {
          line = 6;
        }
        break;
      case '192.168.1.77':
        {
          line = 7;
        }
        break;
      case '192.168.1.78':
        {
          line = 8;
        }
        break;
      case '192.168.1.79':
        {
          line = 9;
        }
        break;
      default:
        line = 1;
    }
    return line;
  }

  static Color getColorByLine(int line) {
    // // if (line % 2 == 0)
    // return Color.fromARGB(50, 100, 150, 150);
    // // else
    // //   return Color.fromARGB(80, 100, 150, 150);
    Color result = Colors.blueAccent;
    switch (line) {
      case 1:
        result = const Color.fromARGB(50, 100, 150, 150);
        break;
      case 2:
        result = const Color.fromARGB(70, 100, 150, 150);
        break;
      case 3:
        result = const Color.fromARGB(90, 100, 150, 150);
        break;
      case 4:
        result = const Color.fromARGB(50, 120, 200, 250);
        break;
      case 5:
        result = const Color.fromARGB(70, 120, 200, 250);
        break;
      case 6:
        result = const Color.fromARGB(90, 120, 200, 250);
        break;
      case 7:
        result = const Color.fromARGB(50, 160, 200, 250);
        break;
      case 8:
        result = const Color.fromARGB(70, 160, 200, 250);
        break;
      case 9:
        result = const Color.fromARGB(90, 160, 200, 250);
        break;
      default:
        result = Colors.blue;
    }
    return result;
  }

  static Color getColorByPercent(double percent) {
    Color result = Colors.yellow;

    if (percent <= 0.25) {
      result = Colors.red;
    } else if (percent <= 0.5) {
      result = Colors.orange;
    } else if (percent <= 0.75) {
      result = Colors.amber;
    } else {
      result = Colors.green;
    }
    return result;
  }

  static Color getColorByQty(int qty, int target) {
    Color result = Colors.yellow;
    int ration = (qty / target * 100).round();
    if (ration <= 25) {
      result = Colors.redAccent;
    } else if (ration <= 50) {
      result = Colors.orange;
    } else if (ration <= 75) {
      result = const Color.fromARGB(255, 249, 227, 25);
    } else {
      result = Colors.greenAccent;
    }
    return result;
  }

  static Color getColorByQty2(int qty, int target) {
    Color result = const Color.fromRGBO(248, 240, 168, 1);
    int ration = (qty / target * 100).round();
    if (ration <= 25) {
      result = const Color.fromARGB(255, 245, 31, 16);
    } else if (ration <= 50) {
      result = const Color.fromARGB(255, 216, 130, 2);
    } else if (ration <= 75) {
      result = const Color.fromARGB(255, 240, 220, 37);
    } else {
      result = const Color.fromARGB(255, 10, 186, 19);
    }
    return result;
  }

  static bool parseBool(int integer) {
    if (integer > 0) {
      return true;
    } else {
      return false;
    }
  }

  static String getLinkImage(String orgLink) {
    // https://drive.google.com/file/d/1-3zgxOg_AyWoTkEu8F21WvNX-kcRwChB/view?usp=drive_link
    // file ID : 1-3zgxOg_AyWoTkEu8F21WvNX-kcRwChB
    // -> https://drive.google.com/uc?export=view&id=<FILE_ID>
    // https://drive.google.com/uc?export=view&id=1-3zgxOg_AyWoTkEu8F21WvNX-kcRwChB

    // https://drive.google.com/file/d/11HhYkZ00h6HwiUnXatTXUMUIuiVvrENK/view?usp=drive_link
    String link =
        // 'https://drive.google.com/uc?export=view&id=';
        'https://drive.google.com/uc?export=download&id=';
    try {
      String fileId = orgLink.substring(32, 65);
      // String fileId = orgLink
      //     .split('https://drive.google.com/file/d/')[0]
      //     .toString()
      //     .split('/view?usp=drive_link')[0]
      //     .toString();
      link += fileId;
      print('org link : $orgLink');
      print('fileId : $fileId');
      print('direct link -> : $link');
      return link;
    } catch (e) {
      print(e);
      return 'https://drive.google.com/uc?export=view&id=1-L3t8Rwj2DsVEeNzyGLgI7U7v06jaciL';
    }
  }

  static Future<void> playAudio() async {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/notification_sound.wav"),
        autoStart: true, volume: 1.0);
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static DateTime findLastDateOfTheMonth(DateTime dateTime) {
    // print(
    //     'findLastDateOfTheMonth $dateTime => ${DateTime(dateTime.year, dateTime.month + 1, 0)}');
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }

  static DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    // print(
    //     'findFirstDateOfTheMonth $dateTime => ${DateTime(dateTime.year, dateTime.month, 1)}');
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  static int findWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  static Color getRandomColor() {
    Random random = Random();
    Color color = Color.fromARGB(
        random.nextInt(50) + 100,
        random.nextInt(50) + 150,
        random.nextInt(50) + 150,
        random.nextInt(50) + 150);
    return color;
  }

  static Color getColorByWorklayer(String name) {
    Color color = Colors.yellow;
    switch (name) {
      case 'Than truoc':
      case 'Hoan thanh':
        color = Colors.yellow;
        break;
      case 'Non':
        color = Colors.blue;
        break;
      case 'Tay':
        color = Colors.green;
        break;
      default:
    }
    return color;
  }

  static Widget clockAppBar(BuildContext context) {
    return Container(
      width: 210, height: g.appBarH,
      color: Colors.transparent,
      // height: g.appBarH ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              DateFormat(g.dateFormatVi).format(
                g.today,
              ),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          // DigitalClock(
          //   digitAnimationStyle: Curves.fastOutSlowIn,
          //   areaDecoration: BoxDecoration(color: Colors.transparent),
          //   hourMinuteDigitTextStyle: Theme.of(context)
          //       .textTheme
          //       .headlineMedium!
          //       .copyWith(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: g.fontSizeAppbar),
          //   secondDigitTextStyle: TextStyle(
          //     color: Colors.greenAccent,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 10,
          //   ),
          //   colon: Text(
          //     ":",
          //     style: TextStyle(
          //         color: Colors.tealAccent,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 17),
          //   ),
          // ),
        ],
      ),
    );
  }

  // static Widget getClock(BuildContext context) {
  //   return Container(
  //     width: 160,
  //     color: const Color.fromRGBO(0, 0, 0, 0.122),
  //     height: 65,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         DigitalClock(
  //           digitAnimationStyle: Curves.fastOutSlowIn,
  //           areaDecoration: BoxDecoration(color: Colors.transparent),
  //           hourMinuteDigitTextStyle: Theme.of(context)
  //               .textTheme
  //               .headlineMedium!
  //               .copyWith(
  //                   color: Colors.blueAccent,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 34),
  //           colon: Text(
  //             ":",
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static Widget noData() {
    return Container(
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.asset('assets/noData.png'),
          ),
          const Text(
            'KHÔNG CÓ DỮ LIỆU !',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  static Widget loadFail() {
    return Container(
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.asset('assets/noData.png'),
          ),
          const Text(
            'Load failed ! Check wifi & restart App',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  static Widget showNotification() {
    // playAudio();
    return FittedBox(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: g.screenWidth,
            height: g.screenHeight - g.appBarH,
            color: Colors.lime[100],
            child: AutoSizeText(
              textAlign: TextAlign.start,
              softWrap: true,
              maxFontSize: 70,
              overflow: TextOverflow.ellipsis,
              minFontSize: 16,
              g.thongbao.getNoidung.toString(),
              style: TextStyle(
                  fontSize: 70,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
              maxLines: 25,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/speaker.gif')),
          )
        ],
      ),
    );
  }

  static bool checkThongBao() {
    print(g.thongbao);
    DateTime time = DateTime.now();
    bool result = false;
    if (!g.thongbao.getOnOff) {
      g.title = "Sản lượng & tỉ lệ lỗi".toUpperCase();
      result = false;
    } else {
      DateTime timeBegin1 = g.thongbao.getThoigian1;
      DateTime timeEnd1 =
          timeBegin1.add(Duration(minutes: g.thongbao.getThoiluongPhut));
      DateTime timeBegin2 = g.thongbao.getThoigian2;
      DateTime timeEnd2 =
          timeBegin2.add(Duration(minutes: g.thongbao.getThoiluongPhut));
      DateTime timeBegin3 = g.thongbao.getThoigian3;
      DateTime timeEnd3 =
          timeBegin3.add(Duration(minutes: g.thongbao.getThoiluongPhut));

      if ((time.isAfter(timeBegin1) && time.isBefore(timeEnd1)) ||
          (time.isAfter(timeBegin2) && time.isBefore(timeEnd2)) ||
          (time.isAfter(timeBegin3) && time.isBefore(timeEnd3))) {
        g.title = g.thongbao.getTieude;
        result = true;
      }
    }

    print('checkThongBao : $result');
    return result;
  }

  static Widget showLoading() {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: g.screenWidth,
        height: g.screenHeight,
        child: SizedBox(
          width: 100,
          height: 200,
          child: Column(children: [
            Image.asset('assets/logo.png'),
            Image.asset('assets/loading.gif'),
          ]),
        ));
  }

  static Future<void> selectT50InspectionData(int summary) async {
    await g.sqlProductionDB
        .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[0], summary)
        .then((value) => {
              if (value.isNotEmpty)
                {
                  g.sqlT50InspectionDataDailys.clear(),
                  g.sqlT50InspectionDataDailys = value
                }
            });
    g.sqlProductionDB
        .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[1], summary)
        .then((value) => {
              if (value.isNotEmpty)
                {
                  g.sqlT50InspectionDataWeeklys.clear(),
                  g.sqlT50InspectionDataWeeklys = value
                }
            });
    await g.sqlProductionDB
        .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[2], summary)
        .then((value) => {
              if (value.isNotEmpty)
                {
                  g.sqlT50InspectionDataMonthlys.clear(),
                  g.sqlT50InspectionDataMonthlys = value
                }
            });
  }

  static Future<void> selectT50InspectionDataOneByOne(int summary) async {
    print('selectT50InspectionDataOneByOne:$summary');
    if (g.isTVLine) {
      g.sqlT50InspectionDataDailys = await g.sqlProductionDB
          .selectSqlT50InspectionData(
              g.currentLine, g.rangeDays, g.timeTypes[0], 0);
    } else {
      g.sqlT50InspectionDataDailys = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[0], 0);
      g.sqlT50InspectionDataWeeklys = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[1], 0);
      g.sqlT50InspectionDataMonthlys = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[2], 0);
      if (summary == 0) return;
      g.sqlT50InspectionDataDailysSummaryAll = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[0], 1);
      g.sqlT50InspectionDataWeeklysSummaryAll = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[1], 1);
      g.sqlT50InspectionDataMonthlysSummaryAll = await g.sqlProductionDB
          .selectSqlT50InspectionData(0, g.rangeDays, g.timeTypes[2], 1);
    }
  }

  static Future<bool> selectTInlineData() async {
    print('selectT58InlineData:');
    List<SqlT58InlineData> sqlT58InlineDataDetailAllProcess = [];
    late DateTime lastDate;
    g.sqlT58InlineDataDailysSumProcess = await g.sqlProductionDB
        .selectT58InlineData(g.currentLine, g.rangeDays, true);
    lastDate = g.sqlT58InlineDataDailysSumProcess.last.getInspectionDate;
    sqlT58InlineDataDetailAllProcess = await g.sqlProductionDB
        .selectT58InlineData(g.currentLine, g.rangeDays, false);
    g.sqlT58InlineDataDailysDetailProcess = sqlT58InlineDataDetailAllProcess;
    g.sqlT58InlineDataLastDay = sqlT58InlineDataDetailAllProcess
        .where((data) => data.inspectionDate == lastDate)
        .toList();

    g.curentItemNo = g.sqlT58InlineDataLastDay.last.getItemNo;
    g.sqlT59TransInline =
        await g.sqlProductionDB.selectSqlT59TransInline(g.curentItemNo);
    return g.sqlT58InlineDataDailysSumProcess.isNotEmpty &&
        sqlT58InlineDataDetailAllProcess.isNotEmpty &&
        sqlT58InlineDataDetailAllProcess.isNotEmpty;
  }

  static Future<void> sellectDataETS(String mo) async {
    print('sellectDataETS:$mo');
    g.etsMoInfo = await g.sqlEtsDB.selectEtsMoInfo(mo);
    g.etsMoQtys = await g.sqlEtsDB.selectEtsMoQty(mo);
  }

  static Widget logo() {
    return Column(children: [
      SizedBox(
        height: 31,
        child: Image.asset(
          'assets/logo_white.png',
        ),
      ),
      Text(
        'Version ${g.version}',
        style: const TextStyle(fontSize: 6),
      )
    ]);
  }

  static Widget circleLine(int currentLine) {
    return CircleAvatar(
      maxRadius: g.appBarH / 2 - 2,
      minRadius: g.appBarH / 2 - 2,
      backgroundColor:
          // g.isLoading
          //     ? Colors.primaries[Random().nextInt(Colors.primaries.length)]
          //     :
          Colors.white,
      child: Center(
        child: Text(
          currentLine.toString(),
          style: const TextStyle(
              color: Colors.blue, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
