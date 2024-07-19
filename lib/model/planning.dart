// ignore_for_file: public_member_api_docs, sort_constructors_first
class Planning {
  int line;
  String brand;
  String style;
  String desc;
  int quantity;
  DateTime beginDate;
  DateTime endDate;
  String comment;
  Planning({
    required this.line,
    required this.brand,
    required this.style,
    required this.desc,
    required this.quantity,
    required this.beginDate,
    required this.endDate,
    required this.comment,
  });
  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getBrand => this.brand;

  set setBrand(band) => this.brand = band;

  get getStyle => this.style;

  set setStyle(style) => this.style = style;

  get getDesc => this.desc;

  set setDesc(desc) => this.desc = desc;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;

  get getBeginDate => this.beginDate;

  set setBeginDate(beginDate) => this.beginDate = beginDate;

  get getEndDate => this.endDate;

  set setEndDate(endDate) => this.endDate = endDate;

  get getComment => this.comment;

  set setComment(comment) => this.comment = comment;

  @override
  String toString() {
    return 'Planning(line: $line, brand: $brand, style: $style, desc: $desc, quantity: $quantity, beginDate: $beginDate, endDate: $endDate, comment: $comment)';
  }
}
