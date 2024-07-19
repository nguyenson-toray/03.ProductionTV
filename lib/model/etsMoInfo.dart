import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EtsMoInfo {
  String mo;
  String style;
  int qty;
  String desc;
  get getMo => this.mo;

  set setMo(mo) => this.mo = mo;

  get getStyle => this.style;

  set setStyle(style) => this.style = style;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getDesc => this.desc;

  set setDesc(desc) => this.desc = desc;
  EtsMoInfo({
    required this.mo,
    required this.style,
    required this.qty,
    required this.desc,
  });

  factory EtsMoInfo.fromMap(Map<String, dynamic> map) {
    return EtsMoInfo(
      mo: map['ZDCODE'] as String,
      style: map['STYLE_NO'] as String,
      qty: map['MY_COUNT'] as int,
      desc: map['XM'] as String,
    );
  }

  factory EtsMoInfo.fromJson(String source) =>
      EtsMoInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EtsMoInfo(mo: $mo, style: $style, qty: $qty, desc: $desc)';
  }
}
