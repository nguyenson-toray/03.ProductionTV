import 'dart:convert';



// ignore_for_file: public_member_api_docs, sort_constructors_first
class PRelaxationFabricTable {
  int shelveNo;
  String floor;
  String kindOfFabric;
  String customer;
  int line;
  String artNo;
  String lotNo;
  String color;
  double qty;
  DateTime beginTime;
  int durationHour;
  get getShelveNo => shelveNo;

  set setShelveNo(shelveNo) => this.shelveNo = shelveNo;

  get getFloor => floor;

  set setFloor(floor) => this.floor = floor;

  get getKindOfFabric => kindOfFabric;

  set setKindOfFabric(kindOfFabric) => this.kindOfFabric = kindOfFabric;

  get getCustomer => customer;

  set setCustomer(customer) => this.customer = customer;

  get getLine => line;

  set setLine(line) => this.line = line;

  get getArtNo => artNo;

  set setArtNo(artNo) => this.artNo = artNo;

  get getLotNo => lotNo;

  set setLotNo(lotNo) => this.lotNo = lotNo;

  get getColor => color;

  set setColor(color) => this.color = color;

  get getQty => qty;

  set setQty(qty) => this.qty = qty;

  get getBeginTime => beginTime;

  set setBeginTime(beginTime) => this.beginTime = beginTime;

  get getDurationHour => durationHour;

  set setDurationHour(durationHour) => this.durationHour = durationHour;
  PRelaxationFabricTable({
    required this.shelveNo,
    required this.floor,
    required this.kindOfFabric,
    required this.customer,
    required this.line,
    required this.artNo,
    required this.lotNo,
    required this.color,
    required this.qty,
    required this.beginTime,
    required this.durationHour,
  });

  PRelaxationFabricTable copyWith({
    int? shelveNo,
    String? floor,
    String? kindOfFabric,
    String? customer,
    int? line,
    String? artNo,
    String? lotNo,
    String? color,
    double? qty,
    DateTime? beginTime,
    int? durationHour,
  }) {
    return PRelaxationFabricTable(
      shelveNo: shelveNo ?? this.shelveNo,
      floor: floor ?? this.floor,
      kindOfFabric: kindOfFabric ?? this.kindOfFabric,
      customer: customer ?? this.customer,
      line: line ?? this.line,
      artNo: artNo ?? this.artNo,
      lotNo: lotNo ?? this.lotNo,
      color: color ?? this.color,
      qty: qty ?? this.qty,
      beginTime: beginTime ?? this.beginTime,
      durationHour: durationHour ?? this.durationHour,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shelveNo': shelveNo,
      'floor': floor,
      'kindOfFabric': kindOfFabric,
      'customer': customer,
      'line': line,
      'artNo': artNo,
      'lotNo': lotNo,
      'color': color,
      'qty': qty,
      'beginTime': beginTime.millisecondsSinceEpoch,
      'durationHour': durationHour,
    };
  }

  factory PRelaxationFabricTable.fromMap(Map<String, dynamic> map) {
    return PRelaxationFabricTable(
      shelveNo: map['shelveNo'] as int,
      floor: map['floor'] as String,
      kindOfFabric: map['kindOfFabric'] as String,
      customer: map['customer'] as String,
      line: map['line'] as int,
      artNo: map['artNo'] as String,
      lotNo: map['lotNo'] as String,
      color: map['color'] as String,
      qty: double.tryParse(map['qty'].toString()) as double,
      beginTime: DateTime.parse(map['beginTime'].toString()),
      durationHour: int.tryParse(map['durationHour'].toString()) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PRelaxationFabricTable.fromJson(String source) =>
      PRelaxationFabricTable.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PRelaxationFabricTable(shelveNo: $shelveNo, floor: $floor, kindOfFabric: $kindOfFabric, customer: $customer, line: $line, artNo: $artNo, lotNo: $lotNo, color: $color, qty: $qty, beginTime: $beginTime, durationHour: $durationHour)';
  }

  @override
  bool operator ==(covariant PRelaxationFabricTable other) {
    if (identical(this, other)) return true;

    return other.shelveNo == shelveNo &&
        other.floor == floor &&
        other.kindOfFabric == kindOfFabric &&
        other.customer == customer &&
        other.line == line &&
        other.artNo == artNo &&
        other.lotNo == lotNo &&
        other.color == color &&
        other.qty == qty &&
        other.beginTime == beginTime &&
        other.durationHour == durationHour;
  }

  @override
  int get hashCode {
    return shelveNo.hashCode ^
        floor.hashCode ^
        kindOfFabric.hashCode ^
        customer.hashCode ^
        line.hashCode ^
        artNo.hashCode ^
        lotNo.hashCode ^
        color.hashCode ^
        qty.hashCode ^
        beginTime.hashCode ^
        durationHour.hashCode;
  }
}
