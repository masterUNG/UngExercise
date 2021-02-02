import 'dart:convert';

class SQLiteModel {
  final int id;
  final String code;
  final String name;
  final String barcodes;
  final String prices;
  final String unitcodes;
  final String amounts;
  final String subtotals;
  SQLiteModel({
    this.id,
    this.code,
    this.name,
    this.barcodes,
    this.prices,
    this.unitcodes,
    this.amounts,
    this.subtotals,
  });

  SQLiteModel copyWith({
    int id,
    String code,
    String name,
    String barcodes,
    String prices,
    String unitcodes,
    String amounts,
    String subtotals,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      barcodes: barcodes ?? this.barcodes,
      prices: prices ?? this.prices,
      unitcodes: unitcodes ?? this.unitcodes,
      amounts: amounts ?? this.amounts,
      subtotals: subtotals ?? this.subtotals,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'barcodes': barcodes,
      'prices': prices,
      'unitcodes': unitcodes,
      'amounts': amounts,
      'subtotals': subtotals,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SQLiteModel(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      barcodes: map['barcodes'],
      prices: map['prices'],
      unitcodes: map['unitcodes'],
      amounts: map['amounts'],
      subtotals: map['subtotals'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SQLiteModel(id: $id, code: $code, name: $name, barcodes: $barcodes, prices: $prices, unitcodes: $unitcodes, amounts: $amounts, subtotals: $subtotals)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SQLiteModel &&
      o.id == id &&
      o.code == code &&
      o.name == name &&
      o.barcodes == barcodes &&
      o.prices == prices &&
      o.unitcodes == unitcodes &&
      o.amounts == amounts &&
      o.subtotals == subtotals;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      barcodes.hashCode ^
      prices.hashCode ^
      unitcodes.hashCode ^
      amounts.hashCode ^
      subtotals.hashCode;
  }
}
