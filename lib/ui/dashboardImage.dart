import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tivnqn/global.dart';
import 'package:tivnqn/myFuntions.dart';

class DashboardImage extends StatefulWidget {
  const DashboardImage(
      {super.key, required this.title, required this.linkImageDirectly});
  final String title;
  final String linkImageDirectly;
  @override
  State<DashboardImage> createState() => _DashboardImageState();
}

class _DashboardImageState extends State<DashboardImage> {
  late Image imageDashboard;

  @override
  void initState() {
    // TODO: implement initState
    initImage(widget.linkImageDirectly);
    Timer.periodic(Duration(seconds: g.config.getReloadSeconds), (timer) async {
      g.configs = await g.sqlApp.sellectConfigs();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: g.appBarH,
        backgroundColor: Colors.blue,
        elevation: 6.0,
        leadingWidth: 95,
        actions: [
          MyFuntions.clockAppBar(context),
          InkWell(
            child: const Icon(
              Icons.refresh_sharp,
              color: Colors.amberAccent,
            ),
            onTap: () {
              updateImmage();
            },
          )
        ],
        leading: MyFuntions.logo(),
        centerTitle: true,
        title: Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: imageDashboard,
    );
  }

  updateImmage() async {
    print('updateImmage');
    Uint8List bytes = (await NetworkAssetBundle(
      Uri.parse(widget.linkImageDirectly),
    ).load(widget.linkImageDirectly))
        .buffer
        .asUint8List();
    if (bytes.isNotEmpty) {
      imageDashboard = Image.memory(bytes,
          fit: BoxFit.fill,
          alignment: Alignment.center,
          height: g.screenHeight - 24,
          width: g.screenWidth);
    }
  }

  Future<void> initImage(String url) async {
    print("initImage from url : $url");
    imageDashboard = Image.network(
        key: Key(url),
        fit: BoxFit.fill,
        alignment: Alignment.center,
        height: g.screenHeight - 24,
        width: g.screenWidth,
        url,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            width: g.screenWidth,
            height: 5,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.tealAccent,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => MyFuntions.loadFail());
  }
}
