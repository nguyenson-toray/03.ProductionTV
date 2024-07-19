// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PCutting {
  int? id;
  String? date;
  int? line;
  String? band;
  String? styleNo;
  String? orderNo;
  String? color;
  String? size;
  int? planQty;
  int? actualQty;
  PCutting({
    this.id,
    this.date,
    this.line,
    this.band,
    this.styleNo,
    this.orderNo,
    this.color,
    this.size,
    this.planQty,
    this.actualQty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'line': line,
      'band': band,
      'styleNo': styleNo,
      'orderNo': orderNo,
      'color': color,
      'size': size,
      'planQty': planQty,
      'actualQty': actualQty,
    };
  }

  factory PCutting.fromMap(Map<String, dynamic> map) {
    return PCutting(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      line: map['line'] != null ? map['line'] as int : null,
      band: map['band'] != null ? map['band'] as String : null,
      styleNo: map['styleNo'] != null ? map['styleNo'] as String : null,
      orderNo: map['orderNo'] != null ? map['orderNo'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
      planQty: map['planQty'] != null ? map['planQty'] as int : null,
      actualQty: map['actualQty'] != null ? map['actualQty'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PCutting.fromJson(String source) =>
      PCutting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PCutting(id: $id, date: $date, line: $line, band: $band, styleNo: $styleNo, orderNo: $orderNo, color: $color, size: $size, planQty: $planQty, actualQty: $actualQty)';
  }
}
