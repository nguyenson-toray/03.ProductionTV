import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SqlT50InspectionData {
  int line;
  String timeType;
  int inspectionType;
  int qty;
  int qtyPass;
  int qtyNG;
  double ratioDefectAll;
  int qtyDefectGroupA;
  int qtyDefectGroupB;
  int qtyDefectGroupC;
  int qtyDefectGroupD;
  int qtyDefectGroupE;
  int qtyDefectGroupF;
  int qtyDefectGroupG;
  int qtyDefectGroupH;
  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getTimeType => this.timeType;

  set setTimeType(timeType) => this.timeType = timeType;

  get getInspectionType => this.inspectionType;

  set setInspectionType(inspectionType) => this.inspectionType = inspectionType;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getQtyPass => this.qtyPass;

  set setQtyPass(qtyPass) => this.qtyPass = qtyPass;

  get getQtyNG => this.qtyNG;

  set setQtyNG(qtyNG) => this.qtyNG = qtyNG;

  get getRatioDefectAll => this.ratioDefectAll;

  set setRatioDefectAll(ratioDefectAll) => this.ratioDefectAll = ratioDefectAll;

  get getQtyDefectGroupA => this.qtyDefectGroupA;

  set setQtyDefectGroupA(qtyDefectGroupA) =>
      this.qtyDefectGroupA = qtyDefectGroupA;

  get getQtyDefectGroupB => this.qtyDefectGroupB;

  set setQtyDefectGroupB(qtyDefectGroupB) =>
      this.qtyDefectGroupB = qtyDefectGroupB;

  get getQtyDefectGroupC => this.qtyDefectGroupC;

  set setQtyDefectGroupC(qtyDefectGroupC) =>
      this.qtyDefectGroupC = qtyDefectGroupC;

  get getQtyDefectGroupD => this.qtyDefectGroupD;

  set setQtyDefectGroupD(qtyDefectGroupD) =>
      this.qtyDefectGroupD = qtyDefectGroupD;

  get getQtyDefectGroupE => this.qtyDefectGroupE;

  set setQtyDefectGroupE(qtyDefectGroupE) =>
      this.qtyDefectGroupE = qtyDefectGroupE;

  get getQtyDefectGroupF => this.qtyDefectGroupF;

  set setQtyDefectGroupF(qtyDefectGroupF) =>
      this.qtyDefectGroupF = qtyDefectGroupF;

  get getQtyDefectGroupG => this.qtyDefectGroupG;

  set setQtyDefectGroupG(qtyDefectGroupG) =>
      this.qtyDefectGroupG = qtyDefectGroupG;

  get getQtyDefectGroupH => this.qtyDefectGroupH;

  set setQtyDefectGroupH(qtyDefectGroupH) =>
      this.qtyDefectGroupH = qtyDefectGroupH;
  SqlT50InspectionData({
    required this.line,
    required this.timeType,
    required this.inspectionType,
    required this.qty,
    required this.qtyPass,
    required this.qtyNG,
    required this.ratioDefectAll,
    required this.qtyDefectGroupA,
    required this.qtyDefectGroupB,
    required this.qtyDefectGroupC,
    required this.qtyDefectGroupD,
    required this.qtyDefectGroupE,
    required this.qtyDefectGroupF,
    required this.qtyDefectGroupG,
    required this.qtyDefectGroupH,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'line': line,
      'timeType': timeType,
      'inspectionType': inspectionType,
      'qty': qty,
      'qtyPass': qtyPass,
      'qtyNG': qtyNG,
      'ratioDefectAll': ratioDefectAll,
      'qtyDefectGroupA': qtyDefectGroupA,
      'qtyDefectGroupB': qtyDefectGroupB,
      'qtyDefectGroupC': qtyDefectGroupC,
      'qtyDefectGroupD': qtyDefectGroupD,
      'qtyDefectGroupE': qtyDefectGroupE,
      'qtyDefectGroupF': qtyDefectGroupF,
      'qtyDefectGroupG': qtyDefectGroupG,
      'qtyDefectGroupH': qtyDefectGroupH,
    };
  }

  factory SqlT50InspectionData.fromMap(Map<String, dynamic> map) {
    return SqlT50InspectionData(
      line: map['line'] == null ? 0 : map['line'] as int,
      timeType: map['timeType'] == null ? '' : map['timeType'] as String,
      inspectionType:
          map['inspectionType'] == null ? 1 : map['inspectionType'] as int,
      qty: map['qty'] == null ? 0 : map['qty'] as int,
      qtyPass: map['qtyPass'] == null ? 0 : map['qtyPass'] as int,
      qtyNG: map['qtyPass'] == null ? 0 : map['qtyNG'] as int,
      ratioDefectAll: map['ratioDefectAll'] == null
          ? 0
          : double.parse(map['ratioDefectAll'].toString()) as double,
      qtyDefectGroupA:
          map['qtyDefectGroupA'] == null ? 0 : map['qtyDefectGroupA'] as int,
      qtyDefectGroupB:
          map['qtyDefectGroupB'] == null ? 0 : map['qtyDefectGroupB'] as int,
      qtyDefectGroupC:
          map['qtyDefectGroupC'] == null ? 0 : map['qtyDefectGroupC'] as int,
      qtyDefectGroupD:
          map['qtyDefectGroupD'] == null ? 0 : map['qtyDefectGroupD'] as int,
      qtyDefectGroupE:
          map['qtyDefectGroupE'] == null ? 0 : map['qtyDefectGroupE'] as int,
      qtyDefectGroupF:
          map['qtyDefectGroupF'] == null ? 0 : map['qtyDefectGroupF'] as int,
      qtyDefectGroupG:
          map['qtyDefectGroupG'] == null ? 0 : map['qtyDefectGroupG'] as int,
      qtyDefectGroupH:
          map['qtyDefectGroupH'] == null ? 0 : map['qtyDefectGroupH'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SqlT50InspectionData.fromJson(String source) =>
      SqlT50InspectionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SqlT50InspectionData(line: $line, timeType: $timeType, inspectionType: $inspectionType, qty: $qty, qtyPass: $qtyPass, qtyNG: $qtyNG, ratioDefectAll: $ratioDefectAll, qtyDefectGroupA: $qtyDefectGroupA, qtyDefectGroupB: $qtyDefectGroupB, qtyDefectGroupC: $qtyDefectGroupC, qtyDefectGroupD: $qtyDefectGroupD, qtyDefectGroupE: $qtyDefectGroupE, qtyDefectGroupF: $qtyDefectGroupF, qtyDefectGroupG: $qtyDefectGroupG, qtyDefectGroupH: $qtyDefectGroupH)';
  }
}
