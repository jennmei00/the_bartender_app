import 'dart:convert';

import 'package:the_bartender_app/models/unit.dart';

class Ingredient {
  String id;
  String name;
  Unit? unit;
  double? amount;
  Ingredient({
    required this.id,
    required this.name,
    this.unit,
    this.amount,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    Unit? unit,
    double? amount,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
    );
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['ingredient_id'] ?? '',
      name: map['name'] ?? '',
      unit: map['unit'] != null ? Unit.fromMap(map['unit']) : null,
      amount: double.tryParse('${map['amount']}'),
    );
  }

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}

class IngredientCreate {
  String id;
  String name;
  IngredientCreate({
    required this.id,
    required this.name,
  });

  IngredientCreate copyWith({
    String? id,
    String? name,
  }) {
    return IngredientCreate(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ingredient_id': id});
    result.addAll({'name': name});

    return result;
  }

  factory IngredientCreate.fromIngredient(Ingredient ingredient) {
    return IngredientCreate(id: ingredient.id, name: ingredient.id);
  }

  factory IngredientCreate.fromMap(Map<String, dynamic> map) {
    return IngredientCreate(
      id: map['ingredient_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientCreate.fromJson(String source) =>
      IngredientCreate.fromMap(json.decode(source));
}
