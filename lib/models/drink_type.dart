import 'dart:convert';

class DrinkType {
  String id;
  String name;

  DrinkType({
    required this.id,
    required this.name,
  });

  DrinkType copyWith({
    String? id,
    String? name,
  }) {
    return DrinkType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'drink_type_id': id});
    result.addAll({'name': name});
  
    return result;
  }

  factory DrinkType.fromMap(Map<String, dynamic> map) {
    return DrinkType(
      id: map['drink_type_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DrinkType.fromJson(String source) => DrinkType.fromMap(json.decode(source));
}
