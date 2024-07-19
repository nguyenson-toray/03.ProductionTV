import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:tivnqn/model/planning.dart';
import 'package:tivnqn/myFuntions.dart';
import 'package:tivnqn/global.dart';

class DashboardPlanning extends StatefulWidget {
  const DashboardPlanning({super.key});

  @override
  State<DashboardPlanning> createState() => _DashboardPlanningState();
}

class _DashboardPlanningState extends State<DashboardPlanning> {
  final scrollController = ScrollController();
  DateTime startChartDate = DateTime.parse('2023-07-01');
  DateTime endChartDate = DateTime.parse('2024-05-31');
  int dayCount = 0;
  double offsetW = 8;
  double cellW = 13;
  double cellHeaderH = 20;
  double cellEventH = 50;
  double currentOffset = 0;
  double maxScrollOffset = 0;
  bool isEmpty = false;
  final GlobalKey keyOffsetToday = GlobalKey();
  // Coordinates
  double? todayX = 100, todayY;

  // This function is called when the user presses the floating button
  void _getOffset(GlobalKey key) {
    RenderBox? box =
        keyOffsetToday.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      setState(() {
        todayX = position.dx;
        todayY = position.dy;
      });
    }
  }

  @override
  void initState() {
    initData();
    currentOffset =
        (DateTime.now().difference(startChartDate).inDays) * offsetW;
    Timer(const Duration(milliseconds: 100), () async {
      scrollController.initialScrollOffset;
      scrollController.jumpTo(currentOffset);
      _getOffset(keyOffsetToday);
    });
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) async {
      if (mounted) {
        g.sqlApp.getPlanning().then((value) => {
              setState(() {
                g.sqlPlanning = value;
                initData();
              })
            });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  void initData() {
    List<DateTime> endDates = [];
    List<DateTime> startDates = [];
    g.sqlPlanning.forEach((element) {
      endDates.add(element.getEndDate);
      startDates.add(element.getBeginDate);
    });
    startDates.sort((a, b) => b.difference(b).inDays);
    endDates.sort((a, b) => a.difference(b).inDays);
    startChartDate = MyFuntions.findFirstDateOfTheMonth(startDates.first);
    endChartDate = MyFuntions.findLastDateOfTheMonth(endDates.last)
        .add(Duration(days: 90));
    dayCount = endChartDate.difference(startChartDate).inDays + 1;
    maxScrollOffset = dayCount * offsetW;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 24,
        backgroundColor: Colors.blue,
        elevation: 6.0,
        centerTitle: true,
        leadingWidth: 95,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              g.todayString,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
        leading: Image.asset(
          'assets/logo_white.png',
        ),
        title: const Text(
          'PRODUCTION PLANNING',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(2, 10, 2, 2),
        child: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                scrollController.jumpTo(scrollController.offset + cellW * 20);
                if (scrollController.offset >= maxScrollOffset) {
                  scrollController.jumpTo(maxScrollOffset);
                }
              }
              if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                scrollController.jumpTo(scrollController.offset - cellW * 20);
                if (scrollController.offset < 0) {
                  scrollController.jumpTo(0);
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: cellHeaderH * 2,
                      child: Text(
                        '''L
I
N
E''',
                        style:
                            TextStyle(fontSize: 6, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      height: cellEventH * 9,
                      width: 25,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey, width: 0.1),
                                color: Colors.white),
                            height: cellEventH,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: cellHeaderH * 2 + cellEventH * 9,
                        width: dayCount * cellW,
                        child: CustomScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          slivers: [
                            SliverList(
                                delegate:
                                    SliverChildBuilderDelegate((_, index) {
                              return Stack(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: cellHeaderH * 2,
                                        width: dayCount * cellW,
                                        child: header()),
                                    event(1),
                                    event(2),
                                    event(3),
                                    event(4),
                                    event(5),
                                    event(6),
                                    event(7),
                                    event(8),
                                    event(9),
                                  ],
                                ),
                                Positioned(
                                    left: todayX! - 25 + cellW / 3,
                                    top: cellHeaderH * 2,
                                    child: Container(
                                      height: cellEventH * 9,
                                      width: 2,
                                      color: Colors.greenAccent,
                                    ))
                              ]);
                            }, childCount: dayCount)),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Use the LEFT - RIGHT arrow buttons on the remote to scroll.',
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget header() {
    return Container(
      // height: cellHeaderH * 2,
      // width: dayCount * cellW,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: cellHeaderH,
            width: dayCount * cellW,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayCount,
                itemBuilder: (context, index) {
                  DateTime date = startChartDate.add(Duration(days: index));
                  String header =
                      '${date.year} - ${DateFormat.MMMM().format(date)}';
                  return date.day == 1
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueGrey, width: 0.1),
                              color: const Color.fromARGB(255, 86, 195, 245)),
                          width: cellW *
                              MyFuntions.findLastDateOfTheMonth(date).day,
                          height: cellHeaderH,
                          child: Text(
                            '$header',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container();
                }),
          ),
          Container(
            height: cellHeaderH,
            width: dayCount * cellW,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dayCount,
              itemBuilder: (context, index) {
                DateTime date = startChartDate.add(Duration(days: index));
                bool isToday = date.toString().substring(0, 10) ==
                    DateTime.now().toString().substring(0, 10);
                return isToday
                    ? Container(
                        key: keyOffsetToday,
                        alignment: Alignment.center,
                        width: cellW,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 18, 240, 29),
                                width: 1.5),
                            color: date.weekday == 7
                                ? Colors.white
                                : isToday
                                    ? Colors.greenAccent
                                    : Colors.lightBlue[100]),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ))
                    : Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 0.1),
                            color: date.weekday == 7
                                ? Colors.white
                                : Colors.lightBlue[100]),
                        width: cellW,
                        height: cellHeaderH,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget event(int line) {
    int eventIndex = 0;
    Planning lineEvent = Planning(
        line: line,
        brand: '',
        style: '',
        desc: '',
        quantity: 0,
        beginDate: DateTime.parse('2023-01-01'),
        endDate: DateTime.parse('2023-01-01'),
        comment: '');
    List<Planning> lineEvents = [];
    lineEvents =
        g.sqlPlanning.where((element) => element.getLine == line).toList();
    lineEvents.sort((a, b) => a.getBeginDate.difference(b.getBeginDate).inDays);
    if (lineEvents.length > 0) {
      lineEvent = lineEvents.first;
    }
    return Container(
        height: cellEventH,
        width: cellW * dayCount,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dayCount,
            itemBuilder: (context, index) {
              DateTime date = startChartDate.add(Duration(days: index));
              if (eventIndex < lineEvents.length - 1 &&
                  date.isAfter(lineEvent.getEndDate)) {
                eventIndex++;
                lineEvent = lineEvents[eventIndex];
              }
              int dayEventCount = lineEvent.getEndDate
                      .difference(lineEvent.getBeginDate)
                      .inDays +
                  1;
              bool isFirstDateEvent =
                  lineEvent.getBeginDate.difference(date).inDays == 0;
              bool inEvent = date.isAfter(
                      lineEvent.getBeginDate.subtract(Duration(days: 1))) &&
                  date.isBefore(lineEvent.getEndDate.add(Duration(days: 1)));
              return inEvent && isFirstDateEvent
                  ? Container(
                      padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.1),
                          color: Colors.white),
                      width: cellW * dayEventCount,
                      child: drawEvent(lineEvent))
                  : Container(
                      width: inEvent ? 0 : cellW,
                      height: cellEventH,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.1),
                          color: Colors.transparent),
                    );
            }));
  }

  Widget drawEvent(Planning event) {
    bool isEmpty = false;
    DateTime beginDate = event.getBeginDate;
    DateTime endDate = event.getEndDate;
    double width = (endDate.difference(beginDate).inDays + 1) * cellW;
    isEmpty = event.getStyle == '';
    String contentStr = isEmpty
        ? event.getComment
        : '${event.getBrand} - ${event.getStyle} ${event.getDesc != '' ? '-  ${event.getDesc}' : ''} - ${event.getQuantity}Pcs ${event.getComment != '' ? ' - Note: ${event.getComment}' : ''}';
    Widget content = Container();
    if (width / contentStr.length > 4) {
      content = Text(contentStr,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.black));
    } else if (width / contentStr.length > 3.0) {
      content = Text(contentStr,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Colors.black));
    } else {
      content = Marquee(
          blankSpace: 20,
          velocity: 20.0,
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
          text: contentStr);
    }
    return isEmpty
        ? Container(
            decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.all(Radius.circular(8))),
            alignment: Alignment.center,
            child: Text(contentStr),
          )
        : ClipPath(
            clipper: ArrowClipper(cellEventH, cellEventH - 7, Edge.RIGHT),
            child: Container(
              padding: EdgeInsets.fromLTRB(2, 2, cellW, 0),
              width: width,
              height: cellEventH,
              // color: MyFuntions.getRandomColor(),
              color: MyFuntions.getColorByLine(event.getLine),
              child: Center(child: content),
            ),
          );
  }
}
