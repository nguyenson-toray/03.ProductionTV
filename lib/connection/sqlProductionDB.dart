import 'dart:io';
import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:tivnqn/model/sqlT50InspectionData.dart';
import 'package:tivnqn/model/sqlT58InlineData.dart';

class SqlProductionDB {
  var connection = ConnectToSqlServerDirectly();
  final String ipLAN = '10.0.1.4';
  final String dbName = 'Production';
  final int port = 1433;
  final String instanceSql = 'MSSQLSERVER';
  final user = 'app';
  final pass = 'Toray@123';
  Future<bool> checkLAN() async {
    bool lanConnection = false;
    const String ipLAN = '10.0.1.4';
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
    print('SqlProductionDB initConnection : $isConnected');
    return isConnected;
  }

  Future<List<SqlT50InspectionData>> selectSqlT50InspectionData(
      int line, int range, String timeType, int summary) async {
    String query = '''
    USE Production 
    EXEC [dbo].[selectT50InspectionData]
    @line = $line,
    @range = $range,
    @timeType = '$timeType',
    @summary = $summary
''';
    List<SqlT50InspectionData> result = [];
    List<Map<String, dynamic>> tempResult = [];
    print('Query selectSqlT50InspectionData : $query  ');
    try {
      SqlT50InspectionData rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = SqlT50InspectionData.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('selectSqlT50InspectionData --> Exception : $e');
    }
    print(' --> result.lenght : ${result.length}');
    return result;
  }

  Future<List<SqlT58InlineData>> selectT58InlineData(
      int line, int range, bool sumAllProcess) async {
    String query = '''
    USE Production 
    EXEC [dbo].[selectT58InlineDataDetail]
    @line = $line,
    @range = $range,
    @sumAllProcess = ${sumAllProcess ? 1 : 0} 
''';
    List<SqlT58InlineData> result = [];
    List<Map<String, dynamic>> tempResult = [];
    print('Query SqlT58InlineData : $query  ');
    try {
      SqlT58InlineData rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = SqlT58InlineData.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('SqlT58InlineData --> Exception : $e');
    }
    print(' --> result.lenght : ${result.length}');

    return result;
  }

  Future<List<SqlT59TransInline>> selectSqlT59TransInline(int itemNo) async {
    String query = '''USE Production 
    EXEC [dbo].[selectT59TransInline]
    @itemNo = $itemNo
    ''';
    List<SqlT59TransInline> result = [];
    List<Map<String, dynamic>> tempResult = [];
    print('Query selectSqlT59TransInline : $query  ');
    try {
      SqlT59TransInline rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = SqlT59TransInline.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('SqlT59TransInline --> Exception : $e');
    }
    print(' --> result.lenght : ${result.length}');

    return result;
  }
}
