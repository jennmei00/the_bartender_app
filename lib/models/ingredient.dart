import 'dart:convert';

import 'package:the_bartender_app/models/unit.dart';

class Ingredient {
  String id;
  String name;
  Unit unit;
  int amount;
  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.amount,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    Unit? unit,
    int? amount,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ingredient_id': id});
    result.addAll({'name': name});
    result.addAll({'unit': unit.toMap()});
    result.addAll({'amount': amount});

    return result;
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['ingredient_id'] ?? '',
      name: map['name'] ?? '',
      unit: map['unit'] != null
          ? Unit.fromMap(map['unit'])
          : Unit(id: '', name: ''),
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}
