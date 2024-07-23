import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SqlT58InlineData {
  int? line;
  int? itemNo;
  int? processNo;
  DateTime? inspectionDate;
  int? qty;
  int? qtyPass;
  int? qtyNG;
  double? ratioDefectAll;
  int? qtyDefectGroupAThongSo;
  int? qtyDefectGroupBPhuLieu;
  int? qtyDefectGroupCNguyHiem;
  int? qtyDefectGroupDVai;
  int? qtyDefectGroupELoiMay;
  int? qtyDefectGroupFNgoaiQuan;
  int? qtyDefectGroupGVatLieu;
  int? qtyDefectGroupHKhac;
  SqlT58InlineData({
    this.line,
    this.itemNo,
    this.processNo,
    this.inspectionDate,
    this.qty,
    this.qtyPass,
    this.qtyNG,
    this.ratioDefectAll,
    this.qtyDefectGroupAThongSo,
    this.qtyDefectGroupBPhuLieu,
    this.qtyDefectGroupCNguyHiem,
    this.qtyDefectGroupDVai,
    this.qtyDefectGroupELoiMay,
    this.qtyDefectGroupFNgoaiQuan,
    this.qtyDefectGroupGVatLieu,
    this.qtyDefectGroupHKhac,
  });
  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getItemNo => this.itemNo;

  set setItemNo(itemNo) => this.itemNo = itemNo;

  get getProcessNo => this.processNo;

  set setProcessNo(processNo) => this.processNo = processNo;

  get getInspectionDate => this.inspectionDate;

  set setInspectionDate(inspectionDate) => this.inspectionDate = inspectionDate;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getQtyPass => this.qtyPass;

  set setQtyPass(qtyPass) => this.qtyPass = qtyPass;

  get getQtyNG => this.qtyNG;

  set setQtyNG(qtyNG) => this.qtyNG = qtyNG;

  get getRatioDefectAll => this.ratioDefectAll;

  set setRatioDefectAll(ratioDefectAll) => this.ratioDefectAll = ratioDefectAll;

  get getQtyDefectGroupAThongSo => this.qtyDefectGroupAThongSo;

  set setQtyDefectGroupAThongSo(qtyDefectGroupAThongSo) =>
      this.qtyDefectGroupAThongSo = qtyDefectGroupAThongSo;

  get getQtyDefectGroupBPhuLieu => this.qtyDefectGroupBPhuLieu;

  set setQtyDefectGroupBPhuLieu(qtyDefectGroupBPhuLieu) =>
      this.qtyDefectGroupBPhuLieu = qtyDefectGroupBPhuLieu;

  get getQtyDefectGroupCNguyHiem => this.qtyDefectGroupCNguyHiem;

  set setQtyDefectGroupCNguyHiem(qtyDefectGroupCNguyHiem) =>
      this.qtyDefectGroupCNguyHiem = qtyDefectGroupCNguyHiem;

  get getQtyDefectGroupDVai => this.qtyDefectGroupDVai;

  set setQtyDefectGroupDVai(qtyDefectGroupDVai) =>
      this.qtyDefectGroupDVai = qtyDefectGroupDVai;

  get getQtyDefectGroupELoiMay => this.qtyDefectGroupELoiMay;

  set setQtyDefectGroupELoiMay(qtyDefectGroupELoiMay) =>
      this.qtyDefectGroupELoiMay = qtyDefectGroupELoiMay;

  get getQtyDefectGroupFNgoaiQuan => this.qtyDefectGroupFNgoaiQuan;

  set setQtyDefectGroupFNgoaiQuan(qtyDefectGroupFNgoaiQuan) =>
      this.qtyDefectGroupFNgoaiQuan = qtyDefectGroupFNgoaiQuan;

  get getQtyDefectGroupGVatLieu => this.qtyDefectGroupGVatLieu;

  set setQtyDefectGroupGVatLieu(qtyDefectGroupGVatLieu) =>
      this.qtyDefectGroupGVatLieu = qtyDefectGroupGVatLieu;

  get getQtyDefectGroupHKhac => this.qtyDefectGroupHKhac;

  set setQtyDefectGroupHKhac(qtyDefectGroupHKhac) =>
      this.qtyDefectGroupHKhac = qtyDefectGroupHKhac;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'line': line,
      'itemNo': itemNo,
      'processNo': processNo,
      'inspectionDate': inspectionDate?.millisecondsSinceEpoch,
      'qty': qty,
      'qtyPass': qtyPass,
      'qtyNG': qtyNG,
      'ratioDefectAll': ratioDefectAll,
      'qtyDefectGroupAThongSo': qtyDefectGroupAThongSo,
      'qtyDefectGroupBPhuLieu': qtyDefectGroupBPhuLieu,
      'qtyDefectGroupCNguyHiem': qtyDefectGroupCNguyHiem,
      'qtyDefectGroupDVai': qtyDefectGroupDVai,
      'qtyDefectGroupELoiMay': qtyDefectGroupELoiMay,
      'qtyDefectGroupFNgoaiQuan': qtyDefectGroupFNgoaiQuan,
      'qtyDefectGroupGVatLieu': qtyDefectGroupGVatLieu,
      'qtyDefectGroupHKhac': qtyDefectGroupHKhac,
    };
  }

  factory SqlT58InlineData.fromMap(Map<String, dynamic> map) {
    return SqlT58InlineData(
      line: map['line'] != null ? map['line'] as int : null,
      itemNo: map['itemNo'] != null ? map['itemNo'] as int : null,
      processNo: map['processNo'] != null ? map['processNo'] as int : null,
      inspectionDate: map['inspectionDate'] != null
          ? DateTime.parse(map['inspectionDate'])
          : null,
      qty: map['qty'] != null ? map['qty'] as int : null,
      qtyPass: map['qtyPass'] != null ? map['qtyPass'] as int : null,
      qtyNG: map['qtyNG'] != null ? map['qtyNG'] as int : null,
      ratioDefectAll: map['ratioDefectAll'] != null
          ? double.parse(map['ratioDefectAll'].toString())
          : null,
      qtyDefectGroupAThongSo: map['qtyDefectGroupAThongSo'] != null
          ? map['qtyDefectGroupAThongSo'] as int
          : null,
      qtyDefectGroupBPhuLieu: map['qtyDefectGroupBPhuLieu'] != null
          ? map['qtyDefectGroupBPhuLieu'] as int
          : null,
      qtyDefectGroupCNguyHiem: map['qtyDefectGroupCNguyHiem'] != null
          ? map['qtyDefectGroupCNguyHiem'] as int
          : null,
      qtyDefectGroupDVai: map['qtyDefectGroupDVai'] != null
          ? map['qtyDefectGroupDVai'] as int
          : null,
      qtyDefectGroupELoiMay: map['qtyDefectGroupELoiMay'] != null
          ? map['qtyDefectGroupELoiMay'] as int
          : null,
      qtyDefectGroupFNgoaiQuan: map['qtyDefectGroupFNgoaiQuan'] != null
          ? map['qtyDefectGroupFNgoaiQuan'] as int
          : null,
      qtyDefectGroupGVatLieu: map['qtyDefectGroupGVatLieu'] != null
          ? map['qtyDefectGroupGVatLieu'] as int
          : null,
      qtyDefectGroupHKhac: map['qtyDefectGroupHKhac'] != null
          ? map['qtyDefectGroupHKhac'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SqlT58InlineData.fromJson(String source) =>
      SqlT58InlineData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SqlT58InlineData(line: $line, itemNo: $itemNo, processNo: $processNo, inspectionDate: $inspectionDate, qty: $qty, qtyPass: $qtyPass, qtyNG: $qtyNG, ratioDefectAll: $ratioDefectAll, qtyDefectGroupAThongSo: $qtyDefectGroupAThongSo, qtyDefectGroupBPhuLieu: $qtyDefectGroupBPhuLieu, qtyDefectGroupCNguyHiem: $qtyDefectGroupCNguyHiem, qtyDefectGroupDVai: $qtyDefectGroupDVai, qtyDefectGroupELoiMay: $qtyDefectGroupELoiMay, qtyDefectGroupFNgoaiQuan: $qtyDefectGroupFNgoaiQuan, qtyDefectGroupGVatLieu: $qtyDefectGroupGVatLieu, qtyDefectGroupHKhac: $qtyDefectGroupHKhac)';
  }
}

class SqlT59TransInline {
  int processNo;
  String majorV;
  String majorJ;
  String proV;
  String proJ;
  SqlT59TransInline({
    required this.processNo,
    required this.majorV,
    required this.majorJ,
    required this.proV,
    required this.proJ,
  });

  @override
  String toString() {
    return 'SqlT59TransInline(processNo: $processNo, majorV: $majorV, majorJ: $majorJ, proV: $proV, proJ: $proJ)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'processNo': processNo,
      'majorV': majorV,
      'majorJ': majorJ,
      'proV': proV,
      'proJ': proJ,
    };
  }

  factory SqlT59TransInline.fromMap(Map<String, dynamic> map) {
    return SqlT59TransInline(
      processNo: map['processNo'] as int,
      majorV: map['majorV'] as String,
      majorJ: map['majorJ'] as String,
      proV: map['proV'] as String,
      proJ: map['proJ'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SqlT59TransInline.fromJson(String source) =>
      SqlT59TransInline.fromMap(json.decode(source) as Map<String, dynamic>);
}
