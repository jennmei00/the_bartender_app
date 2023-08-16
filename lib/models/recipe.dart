import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/models/user.dart';

class RecipeDetail {
  String id;
  String name;
  DateTime creationDate;
  DateTime? editDate;
  int prepTimeMinutes;
  bool alcoholic;
  String instruction;
  String descriiption;
  //TODOUint8List? image;
  User user;
  Season season;
  DrinkType drinkType;
  List<Tool>? tools;
  List<Ingredient> ingredients;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.creationDate,
    this.editDate,
    required this.prepTimeMinutes,
    required this.alcoholic,
    required this.instruction,
    required this.descriiption,
    //TODOthis.image,
    required this.user,
    required this.season,
    required this.drinkType,
    required this.tools,
    required this.ingredients,
  });

  RecipeDetail copyWith({
    String? id,
    String? name,
    DateTime? creationDate,
    DateTime? editDate,
    int? prepTimeMinutes,
    bool? alcoholic,
    String? instruction,
    String? descriiption,
    Uint8List? image,
    User? user,
    Season? season,
    DrinkType? drinkType,
    List<Tool>? tools,
    List<Ingredient>? ingredients,
  }) {
    return RecipeDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
      editDate: editDate ?? this.editDate,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      alcoholic: alcoholic ?? this.alcoholic,
      instruction: instruction ?? this.instruction,
      descriiption: descriiption ?? this.descriiption,
      //TODOimage: image ?? this.image,
      user: user ?? this.user,
      season: season ?? this.season,
      drinkType: drinkType ?? this.drinkType,
      tools: tools ?? this.tools,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  factory RecipeDetail.fromMap(Map<String, dynamic> map) {
    return RecipeDetail(
      id: map['recipe_id'] ?? '',
      name: map['name'] ?? '',
      creationDate: DateTime.parse(map['creation_date']),
      editDate:
          map['edit_date'] != null ? DateTime.parse(map['edit_date']) : null,
      prepTimeMinutes: map['prep_time_minutes']?.toInt() ?? 0,
      alcoholic: map['alcoholic'] ?? false,
      instruction: map['instruction'] ?? '',
      descriiption: map['description'] ?? '',
      //TODOimage:
      //TODOmap['image'], // != null ? Uint8List.fromMap(map['image']) : null,
      user: User.fromMap(map['user']),
      season: Season.fromMap(map['season']),
      drinkType: DrinkType.fromMap(map['drink_type']),
      tools: map['tools'] == null
          ? null
          : List<Tool>.from(map['tools']?.map((x) => Tool.fromMap(x))),
      ingredients: List<Ingredient>.from(
          map['ingredients']?.map((x) => Ingredient.fromMap(x))),
    );
  }


  factory RecipeDetail.fromJson(String source) =>
      RecipeDetail.fromMap(json.decode(source));
}

class Recipe {
  String id;
  String name;
  bool alcoholic;
  User user;
  Season season;
  DrinkType drinkType;
  //TODOImage
  Recipe({
    required this.id,
    required this.name,
    required this.alcoholic,
    required this.user,
    required this.season,
    required this.drinkType,
  });

  Recipe copyWith({
    String? id,
    String? name,
    bool? alcoholic,
    User? user,
    Season? season,
    DrinkType? drinkType,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      alcoholic: alcoholic ?? this.alcoholic,
      user: user ?? this.user,
      season: season ?? this.season,
      drinkType: drinkType ?? this.drinkType,
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['recipe_id'] ?? '',
      name: map['name'] ?? '',
      alcoholic: map['alcoholic'] ?? false,
      user: User.fromMap(map['user']),
      season: Season.fromMap(map['season']),
      drinkType: DrinkType.fromMap(map['drink_type']),
    );
  }

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));
}
