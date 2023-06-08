import 'dart:typed_data';

import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';

class Recipe {
  String id;
  String name;
  DateTime creationDate;
  DateTime? editDate;
  int prepTimeMinutes;
  bool alcoholic;
  String instruction;
  String descriiption;
  int rating;
  Uint8List? image;
  Season season;
  DrinkType drinkType;
  List<Tool> tools;
  List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.creationDate,
    this.editDate,
    required this.prepTimeMinutes,
    required this.alcoholic,
    required this.instruction,
    required this.descriiption,
    required this.rating,
    this.image,
    required this.season,
    required this.drinkType,
    required this.tools,
    required this.ingredients,
  });

  Recipe copyWith({
    String? id,
    String? name,
    DateTime? creationDate,
    DateTime? editDate,
    int? prepTimeMinutes,
    bool? alcoholic,
    String? instruction,
    String? descriiption,
    int? rating,
    Uint8List? image,
    Season? season,
    DrinkType? drinkType,
    List<Tool>? tools,
    List<Ingredient>? ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
      editDate: editDate ?? this.editDate,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      alcoholic: alcoholic ?? this.alcoholic,
      instruction: instruction ?? this.instruction,
      descriiption: descriiption ?? this.descriiption,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      season: season ?? this.season,
      drinkType: drinkType ?? this.drinkType,
      tools: tools ?? this.tools,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
