import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/models/unit.dart';
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
  int rating;
  //TODOUint8List? image;
  User user;
  Season season;
  DrinkType drinkType;
  List<Tool> tools;
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
    required this.rating,
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
    int? rating,
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
      rating: rating ?? this.rating,
      //TODOimage: image ?? this.image,
      user: user ?? this.user,
      season: season ?? this.season,
      drinkType: drinkType ?? this.drinkType,
      tools: tools ?? this.tools,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'recipe_id': id});
    result.addAll({'name': name});
    result.addAll({'creationDate': creationDate.millisecondsSinceEpoch});
    if (editDate != null) {
      result.addAll({'editDate': editDate!.millisecondsSinceEpoch});
    }
    result.addAll({'prepTimeMinutes': prepTimeMinutes});
    result.addAll({'alcoholic': alcoholic});
    result.addAll({'instruction': instruction});
    result.addAll({'descriiption': descriiption});
    result.addAll({'rating': rating});
    //TODOresult.addAll({'image': image!.toMap()});
    result.addAll({'user': user.toMap()});
    result.addAll({'season': season.toMap()});
    result.addAll({'drinkType': drinkType.toMap()});
    result.addAll({'tools': tools.map((x) => x.toMap()).toList()});
    result.addAll({'ingredients': ingredients.map((x) => x.toMap()).toList()});

    return result;
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
      rating: map['rating']?.toInt() ?? 0,
      //TODOimage:
      //TODOmap['image'], // != null ? Uint8List.fromMap(map['image']) : null,
      user: User.fromMap(map['user']),
      season: Season.fromMap(map['season']),
      drinkType: DrinkType.fromMap(map['drink_type']),
      tools: map['tools'] == null
          ? [Tool(id: '', name: '')]
          : List<Tool>.from(map['tools']?.map((x) => Tool.fromMap(x))),
      ingredients: map['tools'] == null
          ? [
              Ingredient(
                  id: '', name: '', amount: 0, unit: Unit(id: '', name: ''))
            ]
          : List<Ingredient>.from(
              map['ingredients']?.map((x) => Ingredient.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetail.fromJson(String source) =>
      RecipeDetail.fromMap(json.decode(source));
}

class Recipe {
  String id;
  String name;
  double rating;
  bool alcoholic;
  User user;
  Season season;
  DrinkType drinkType;
  //TODOImage
  Recipe({
    required this.id,
    required this.name,
    required this.rating,
    required this.alcoholic,
    required this.user,
    required this.season,
    required this.drinkType,
  });

  Recipe copyWith({
    String? id,
    String? name,
    double? rating,
    bool? alcoholic,
    User? user,
    Season? season,
    DrinkType? drinkType,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
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
      rating: map['rating']?.toDouble() ?? 0.0,
      alcoholic: map['alcoholic'] ?? false,
      user: User.fromMap(map['user']),
      season: Season.fromMap(map['season']),
      drinkType: DrinkType.fromMap(map['drink_type']),
    );
  }

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));
}
