import 'dart:io';

import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:tivnqn/model/etsMoInfo.dart';
import 'package:tivnqn/model/etsMoQty.dart';

class SqlEtsDB {
  var connection = ConnectToSqlServerDirectly();
  final String ipLAN = '192.168.1.11';
  final String dbName = 'ETSDB_TI';
  final int port = 1433;
  final String instanceSql = 'MSSQLSERVER';
  final user = 'app';
  final pass = 'Toray@123';

  Future<bool> initConnection() async {
    bool isConnected = false;
    try {
      bool lanConnection = false;
      await Socket.connect(ipLAN, port, timeout: const Duration(seconds: 3))
          .then((socket) {
        // do what need to be done
        lanConnection = true;
        // Don't forget to close socket
        socket.destroy();
      });
      print('SqlETSDB checkLAN IP : $ipLAN  port : $port : $lanConnection');
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

    print('SqlETSDB initConnection : $isConnected');
    return isConnected;
  }

  Future<EtsMoInfo> selectEtsMoInfo(String mo) async {
    String query = '''
USE ETSDB_TI
EXEC [1_GetMOInfo]
@mo='${mo}'
''';
    EtsMoInfo result =
        EtsMoInfo(mo: 'ZDCODE', style: 'STYLE_NO', qty: 0, desc: 'XM');
    List<Map<String, dynamic>> tempResult = [];
    print('Query selectEtsMoInfo : $query  ');
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                result = EtsMoInfo.fromMap(tempResult.first)
              }
          });
    } catch (e) {
      print('selectEtsMoInfo ${mo} --> Exception : ' + e.toString());
    }
    print(' --> result : ' + result.toString());
    return result;
  }

  Future<List<EtsMoQty>> selectEtsMoQty(String mo) async {
    String query = '''
USE ETSDB_TI
EXEC [1_GetMOQty]
@mo='${mo}'
''';

    List<EtsMoQty> result = [];
    List<Map<String, dynamic>> tempResult = [];
    print('Query selectEtsMoQty : $query  ');
    try {
      var rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('=> ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = EtsMoQty.fromMap(element),
                    result.add(rowData),
                  }
              }
          });
    } catch (e) {
      print('selectEtsMoQty ${mo} --> Exception : ' + e.toString());
    }
    print(' --> result.lenght : ' + result.length.toString());
    return result;
  }
}
