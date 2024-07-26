// ignore_for_file: public_member_api_docs, sort_constructors_first

class Configs {
  int? id;
  String? section;
  String? ip;
  String? mac;
  String? imageLink;
  int? doExercise;
  int? reloadSeconds;
  int? announcementOnly;

  String? productionChartBegin;
  int? productionChartDurationMinute;
  int? productionChartRangeDay;
  String? etsMO;
  int? get getId => id;

  set setId(int? id) => this.id = id;

  get getSection => section;

  set setSection(section) => this.section = section;

  get getIp => ip;

  set setIp(ip) => this.ip = ip;

  get getMac => mac;

  set setMac(mac) => this.mac = mac;

  get getImageLink => imageLink;

  set setImageLink(imageLink) => this.imageLink = imageLink;

  get getDoExercise => doExercise;

  set setDoExercise(doExercise) => this.doExercise = doExercise;

  get getReloadSeconds => reloadSeconds;

  set setReloadSeconds(reloadSeconds) => this.reloadSeconds = reloadSeconds;
  get getAnnouncementOnly => announcementOnly;

  set setAnnouncementOnly(announcementOnly) =>
      this.announcementOnly = announcementOnly;
  get getProductionChartBegin => productionChartBegin;

  set setProductionChartBegin(productionChartBegin) =>
      this.productionChartBegin = productionChartBegin;

  get getProductionChartDurationMinute => productionChartDurationMinute;

  set setProductionChartDurationMinute(productionChartDurationMinute) =>
      this.productionChartDurationMinute = productionChartDurationMinute;

  get getProductionChartRangeDay => productionChartRangeDay;

  set setProductionChartRangeDay(productionChartRangeDay) =>
      this.productionChartRangeDay = productionChartRangeDay;

  get getEtsMO => etsMO;

  set setEtsMO(etsMO) => this.etsMO = etsMO;
  Configs({
    this.id,
    this.section,
    this.ip,
    this.mac,
    this.imageLink,
    this.doExercise,
    this.reloadSeconds,
    this.announcementOnly,
    this.productionChartBegin,
    this.productionChartDurationMinute,
    this.productionChartRangeDay,
    this.etsMO,
  });

  Configs copyWith({
    int? id,
    String? section,
    String? ip,
    String? mac,
    String? imageLink,
    int? doExercise,
    String? doExerciseTime,
    int? reloadSeconds,
    int? announcementOnly,
    int? productionChart,
    String? productionChartBegin,
    int? productionChartDurationMinute,
    int? productionChartRangeDay,
    int? etsChart,
    String? etsChartBegin,
    int? etsChartDurationMinute,
    String? etsMO,
  }) {
    return Configs(
      id: id ?? this.id,
      section: section ?? this.section,
      ip: ip ?? this.ip,
      mac: mac ?? this.mac,
      imageLink: imageLink ?? this.imageLink,
      reloadSeconds: reloadSeconds ?? this.reloadSeconds,
      announcementOnly: announcementOnly ?? this.announcementOnly,
      productionChartBegin: productionChartBegin ?? this.productionChartBegin,
      productionChartDurationMinute:
          productionChartDurationMinute ?? this.productionChartDurationMinute,
      productionChartRangeDay:
          productionChartRangeDay ?? this.productionChartRangeDay,
      etsMO: etsMO ?? this.etsMO,
    );
  }

  factory Configs.fromMap(Map<String, dynamic> map) {
    return Configs(
      id: map['id'] != null ? map['id'] as int : null,
      section: map['section'] != null ? map['section'] as String : null,
      ip: map['ip'] != null ? map['ip'] as String : null,
      mac: map['mac'] != null ? map['mac'] as String : null,
      imageLink: map['imageLink'] != null ? map['imageLink'] as String : null,
      doExercise: map['doExercise'] != null ? map['doExercise'] as int : null,
      reloadSeconds:
          map['reloadSeconds'] != null ? map['reloadSeconds'] as int : null,
      announcementOnly: map['announcementOnly'] != null
          ? map['announcementOnly'] as int
          : null,
      productionChartBegin: map['productionChartBegin'] != null
          ? map['productionChartBegin'] as String
          : null,
      productionChartDurationMinute:
          map['productionChartDurationMinute'] != null
              ? map['productionChartDurationMinute'] as int
              : null,
      productionChartRangeDay: map['productionChartRangeDay'] != null
          ? map['productionChartRangeDay'] as int
          : null,
      etsMO: map['etsMO'] != null ? map['etsMO'] as String : null,
    );
  }
}
