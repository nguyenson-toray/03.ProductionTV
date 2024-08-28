import 'dart:io';

import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:tivnqn/model/configs.dart';
import 'package:tivnqn/model/planning.dart';
import 'package:tivnqn/model/preparation/pCutting.dart';
import 'package:tivnqn/model/preparation/pDispatch.dart';
import 'package:tivnqn/model/preparation/pRelaxationfabricTable.dart';
import 'package:tivnqn/model/thongbao.dart';

class SqlApp {
  var connection = ConnectToSqlServerDirectly();
  final String ipLAN = '10.0.1.4';
  final String dbName = 'App';
  final String instanceSql = 'MSSQLSERVER';
  final user = 'app';
  final pass = 'Toray@123';
  Future<bool> checkLAN() async {
    bool lanConnection = false;

    const int port = 1433;
    await Socket.connect(ipLAN, port, timeout: const Duration(seconds: 3))
        .then((socket) {
      // do what need to be done
      print('Connection to IP LAN : $ipLAN:$port OK');
      lanConnection = true;
      // Don't forget to close socket
      socket.destroy();
    });
    print(
        'SqlProductionDB checkLAN IP : $ipLAN  port : $port : $lanConnection');
    return lanConnection;
  }

  Future<bool> initConnection() async {
    bool isConnected = false;
    try {
      bool lanConnection = await checkLAN();
      if (lanConnection) {
        isConnected = await connection.initializeConnection(
          ipLAN,
          dbName,
          user,
          pass,
          instance: instanceSql,
        );
      }
    } catch (e) {
      print(e);
    }
    print('Sql-App-DB initConnection : $isConnected');
    return isConnected;
  }

  Future<List<Planning>> getPlanning() async {
    String query =
        '''SELECT line,brand, style, quantity, beginDate, endDate, comment, description
        FROM [App].[dbo].[Planning]''';
    List<Planning> result = [];
    var tempResult;
    print('getPlanning : $query');
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    result.add(
                      Planning(
                        line: element['line'],
                        brand: element['brand'] ?? '',
                        style: element['style'] ?? '',
                        desc: element['description'] ?? '',
                        quantity: element['quantity'] ?? 0,
                        beginDate: DateTime.parse(element['beginDate']),
                        endDate: DateTime.parse(element['endDate']),
                        comment: element['comment'] ?? '',
                      ),
                    )
                  }
              }
          });
      print(result);
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<List<Configs>> sellectConfigs() async {
    List<Configs> result = [];
    List<Map<String, dynamic>> tempResult = [];
    const String query = '''select * from [App].[dbo].[Configs] ''';
    print('Query : $query  ');
    try {
      Configs rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = Configs.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('sellectConfigs --> Exception : $e');
    }
    return result;
  }

  Future<ThongBao> sellectThongBao() async {
    DateTime now = DateTime.now();
    ThongBao result = ThongBao(
        onOff: false,
        tieude: 'tieude',
        noidung: 'noidung',
        thoiluongPhut: 10,
        thoigian1: now,
        thoigian2: now,
        thoigian3: now);
    List<Map<String, dynamic>> tempResult = [];
    const String query = '''select * from [App].[dbo].[thongbao] ''';
    print('Query : $query  ');
    try {
      var rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                result = ThongBao.fromMap(tempResult.first),
              }
          });
    } catch (e) {
      print('sellectThongBao --> Exception : $e');
    }
    return result;
  }

  Future<List<PCutting>> sellectPCutting() async {
    List<PCutting> result = [];
    List<Map<String, dynamic>> tempResult = [];

    const String query = '''select * from [App].[dbo].[PCutting]
        WHERE CAST(date AS DATE) = CAST(GETDATE() AS DATE) 
        ''';
    print('Query : $query  ');
    try {
      PCutting rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    print(element),
                    rowData = PCutting.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('sellectPCutting --> Exception : $e');
    }
    return result;
  }

  Future<List<PDispatch>> sellectPDispatch() async {
    List<PDispatch> result = [];
    List<Map<String, dynamic>> tempResult = [];

    const String query = '''select * from [App].[dbo].[PDispatch]
        WHERE CAST(date AS DATE) = CAST(GETDATE() AS DATE) 
        ''';
    print('Query : $query  ');
    try {
      PDispatch rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = PDispatch.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('sellect PDispatch --> Exception : $e');
    }
    return result;
  }

  Future<List<PRelaxationFabricTable>> sellectPRelaxationFabricTable() async {
    List<PRelaxationFabricTable> result = [];
    List<Map<String, dynamic>> tempResult = [];
    const String query = '''select * from [App].[dbo].[PRelaxationFabricNew1]
    ORDER BY Id ASC''';
    print('Query : $query  ');
    try {
      PRelaxationFabricTable rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = PRelaxationFabricTable.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('sellect sellectPRelaxationFabricTable --> Exception : $e');
    }
    return result;
  }
}
