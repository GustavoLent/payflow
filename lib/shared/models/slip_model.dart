import 'dart:convert';

class SlipModel {
  final String name;
  final String dueDate;
  final double value;
  final String barcode;

  SlipModel({
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
  });

  SlipModel copyWith({
    String name,
    String dueDate,
    double value,
    String barcode,
  }) {
    return SlipModel(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
    };
  }

  factory SlipModel.fromMap(Map<String, dynamic> map) {
    return SlipModel(
      name: map['name'],
      dueDate: map['dueDate'],
      value: map['value'],
      barcode: map['barcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SlipModel.fromJson(String source) =>
      SlipModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SlipModel(name: $name, dueDate: $dueDate, value: $value, barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SlipModel &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.value == value &&
        other.barcode == barcode;
  }

  @override
  int get hashCode {
    return name.hashCode ^ dueDate.hashCode ^ value.hashCode ^ barcode.hashCode;
  }
}
