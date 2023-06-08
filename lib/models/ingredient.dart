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
}
