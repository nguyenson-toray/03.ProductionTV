// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:tivnqn/global.dart';

class ThongBao {
  bool onOff;
  String tieude;
  String noidung;
  int thoiluongPhut;
  DateTime thoigian1;
  DateTime thoigian2;
  DateTime thoigian3;
  get getOnOff => onOff;

  set setOnOff(onOff) => this.onOff = onOff;

  get getTieude => tieude;

  set setTieude(tieude) => this.tieude = tieude;

  get getNoidung => noidung;

  set setNoidung(noidung) => this.noidung = noidung;

  get getThoiluongPhut => thoiluongPhut;

  set setThoiluongPhut(thoiluongPhut) => this.thoiluongPhut = thoiluongPhut;

  get getThoigian1 => thoigian1;

  set setThoigian1(thoigian1) => this.thoigian1 = thoigian1;

  get getThoigian2 => thoigian2;

  set setThoigian2(thoigian2) => this.thoigian2 = thoigian2;

  get getThoigian3 => thoigian3;

  set setThoigian3(thoigian3) => this.thoigian3 = thoigian3;
  ThongBao({
    required this.onOff,
    required this.tieude,
    required this.noidung,
    required this.thoiluongPhut,
    required this.thoigian1,
    required this.thoigian2,
    required this.thoigian3,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'onOff': onOff,
      'tieude': tieude,
      'noidung': noidung,
      'thoiluongPhut': thoiluongPhut,
      'thoigian1': thoigian1,
      'thoigian2': thoigian2,
      'thoigian3': thoigian3,
    };
  }

  factory ThongBao.fromMap(Map<String, dynamic> map) {
    return ThongBao(
      onOff: map['onOff'] as bool,
      tieude: map['tieude'] as String,
      noidung: map['noidung'] as String,
      thoiluongPhut: map['thoiluongPhut'] as int,
      thoigian1:
          DateTime.parse("${g.todayString} " + map['thoigian1']),
      thoigian2:
          DateTime.parse("${g.todayString} " + map['thoigian2']),
      thoigian3:
          DateTime.parse("${g.todayString} " + map['thoigian3']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ThongBao.fromJson(String source) =>
      ThongBao.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ThongBao(onOff: $onOff, tieude: $tieude , thoiluongPhut: $thoiluongPhut, thoigian1: $thoigian1, thoigian2: $thoigian2, thoigian3: $thoigian3)';
  }

  @override
  bool operator ==(covariant ThongBao other) {
    if (identical(this, other)) return true;

    return other.onOff == onOff &&
        other.tieude == tieude &&
        other.noidung == noidung &&
        other.thoiluongPhut == thoiluongPhut &&
        other.thoigian1 == thoigian1 &&
        other.thoigian2 == thoigian2 &&
        other.thoigian3 == thoigian3;
  }

  @override
  int get hashCode {
    return onOff.hashCode ^
        tieude.hashCode ^
        noidung.hashCode ^
        thoiluongPhut.hashCode ^
        thoigian1.hashCode ^
        thoigian2.hashCode ^
        thoigian3.hashCode;
  }
}
