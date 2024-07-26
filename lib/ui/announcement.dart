import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:tivnqn/global.dart';

class Announcement extends StatefulWidget {
  const Announcement({
    Key? key,
  }) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late Timer myTimer;
  // Cron cron = Cron();
  @override
  void initState() {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/notification_sound.wav"),
        autoStart: true, volume: 0.7);
    if (g.config.getAnnouncementOnly != 1) {
      Timer.periodic(Duration(minutes: g.thongbao.getThoiluongPhut),
          (Timer timer) async {
        Navigator.pop(context);
      });
    }
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) async {
      getAnnouncement();
    });
    // TODO: implement initState
    super.initState();
  }

  getAnnouncement() {
    setState(() async {
      g.thongbao = await g.sqlApp.sellectThongBao();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: g.appBarH,
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 6.0,
          leadingWidth: 95,
          leading: Image.asset(
            'assets/logo_white.png',
          ),
          actions: [Image.asset('assets/speaker.gif')],
          title: Text(
            g.thongbao.getTieude,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FittedBox(
          child: Container(
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
        ));
  }
}
