import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PDispatch {
  int? id;
  String? date;
  int? line;
  String? brand;
  String? styleNo;
  int? orderQty;
  String? color;
  String? size1;
  int? planQty1;
  int? actualQty1;
  String? size2;
  int? planQty2;
  int? actualQty2;
  String? color3;
  String? size3;
  int? planQty3;
  int? actualQty3;
  PDispatch({
    this.id,
    this.date,
    this.line,
    this.brand,
    this.styleNo,
    this.orderQty,
    this.color,
    this.size1,
    this.planQty1,
    this.actualQty1,
    this.size2,
    this.planQty2,
    this.actualQty2,
    this.color3,
    this.size3,
    this.planQty3,
    this.actualQty3,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'line': line,
      'brand': brand,
      'styleNo': styleNo,
      'orderQty': orderQty,
      'color': color,
      'size1': size1,
      'planQty1': planQty1,
      'actualQty1': actualQty1,
      'size2': size2,
      'planQty2': planQty2,
      'actualQty2': actualQty2,
      'color3': color3,
      'size3': size3,
      'planQty3': planQty3,
      'actualQty3': actualQty3,
    };
  }

  factory PDispatch.fromMap(Map<String, dynamic> map) {
    return PDispatch(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      line: map['line'] != null ? map['line'] as int : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      styleNo: map['styleNo'] != null ? map['styleNo'] as String : null,
      orderQty: map['orderQty'] != null ? map['orderQty'] as int : null,
      color: map['color'] != null ? map['color'] as String : null,
      size1: map['size1'] != null ? map['size1'] as String : null,
      planQty1: map['planQty1'] != null ? map['planQty1'] as int : null,
      actualQty1: map['actualQty1'] != null ? map['actualQty1'] as int : null,
      size2: map['size2'] != null ? map['size2'] as String : '',
      planQty2: map['planQty2'] != null ? map['planQty2'] as int : 0,
      actualQty2: map['actualQty2'] != null ? map['actualQty2'] as int : 0,
      color3: map['color3'] != null ? map['color3'] as String : '',
      size3: map['size3'] != null ? map['size3'] as String : '',
      planQty3: map['planQty3'] != null ? map['planQty3'] as int : 0,
      actualQty3: map['actualQty3'] != null ? map['actualQty3'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PDispatch.fromJson(String source) =>
      PDispatch.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PDispatch(id: $id, date: $date, line: $line, brand: $brand, styleNo: $styleNo, orderQty: $orderQty, color: $color, size1: $size1, planQty1: $planQty1, actualQty1: $actualQty1, size2: $size2, planQty2: $planQty2, actualQty2: $actualQty2, color3: $color3, size3: $size3, planQty3: $planQty3, actualQty3: $actualQty3)';
  }
}
