import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EtsMoQty {
  int GxNo;
  String GxCode;
  String gxName;
  int QtyToday;
  String ZDCode;
  int QtyCommulative;
  EtsMoQty({
    required this.GxNo,
    required this.GxCode,
    required this.gxName,
    required this.QtyToday,
    required this.ZDCode,
    required this.QtyCommulative,
  });
  get getGxNo => GxNo;

  set setGxNo(GxNo) => this.GxNo = GxNo;

  get getGxCode => GxCode;

  set setGxCode(GxCode) => this.GxCode = GxCode;

  get getGxName => gxName;

  set setGxName(gxName) => this.gxName = gxName;

  get getQtyToday => QtyToday;

  set setQtyToday(QtyToday) => this.QtyToday = QtyToday;

  get getZDCode => ZDCode;

  set setZDCode(ZDCode) => this.ZDCode = ZDCode;

  get getQtyCommulative => QtyCommulative;

  set setQtyCommulative(QtyCommulative) => this.QtyCommulative = QtyCommulative;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'GxNo': GxNo,
      'GxCode': GxCode,
      'gxName': gxName,
      'QtyToday': QtyToday,
      'ZDCode': ZDCode,
      'QtyCommulative': QtyCommulative,
    };
  }

  factory EtsMoQty.fromMap(Map<String, dynamic> map) {
    return EtsMoQty(
      GxNo: map['GxNo'] as int,
      GxCode: map['GxCode'] as String,
      gxName: map['gxName'] as String,
      QtyToday: map['QtyToday'] == null ? 0 : map['QtyToday'] as int,
      ZDCode: map['ZDCode'] as String,
      QtyCommulative: map['QtyCommulative'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EtsMoQty.fromJson(String source) =>
      EtsMoQty.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MoQty(GxNo: $GxNo, GxCode: $GxCode, gxName: $gxName, QtyToday: $QtyToday, ZDCode: $ZDCode, QtyCommulative: $QtyCommulative)';
  }
}
