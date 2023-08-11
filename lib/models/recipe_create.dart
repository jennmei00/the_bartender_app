import 'dart:convert';

class RecipeCreate {
  String recipeId;
  String name;
  DateTime creationDate;
  DateTime? editDate;
  int prepTimeMinutes;
  bool alcoholic;
  String instruction;
  String description;
  double rating;
  //TODOImage
  String seasonId;
  String drinkTypeId;
  String userId;

  RecipeCreate({
    required this.recipeId,
    required this.name,
    required this.creationDate,
    required this.editDate,
    required this.prepTimeMinutes,
    required this.alcoholic,
    required this.instruction,
    required this.description,
    required this.rating,
    required this.seasonId,
    required this.drinkTypeId,
    required this.userId,
  });

  RecipeCreate copyWith({
    String? recipeId,
    String? name,
    DateTime? creationDate,
    DateTime? editDate,
    int? prepTimeMinutes,
    bool? alcoholic,
    String? instruction,
    String? description,
    double? rating,
    String? seasonId,
    String? drinkTypeId,
    String? userId,
  }) {
    return RecipeCreate(
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
      editDate: editDate ?? this.editDate,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      alcoholic: alcoholic ?? this.alcoholic,
      instruction: instruction ?? this.instruction,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      seasonId: seasonId ?? this.seasonId,
      drinkTypeId: drinkTypeId ?? this.drinkTypeId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'recipe_id': recipeId});
    result.addAll({'name': name});
    result.addAll({'creation_date': creationDate.toIso8601String()});
    result.addAll({'edit_date': editDate?.toIso8601String()});
    result.addAll({'prep_time_minutes': prepTimeMinutes});
    result.addAll({'alcoholic': alcoholic});
    result.addAll({'instruction': instruction});
    result.addAll({'description': description});
    result.addAll({'rating': rating});
    result.addAll({'season_id': seasonId});
    result.addAll({'drink_type_id': drinkTypeId});
    result.addAll({'user_id': userId});
  
    return result;
  }

  factory RecipeCreate.fromMap(Map<String, dynamic> map) {
    return RecipeCreate(
      recipeId: map['recipe_id'] ?? '',
      name: map['name'] ?? '',
      creationDate: DateTime.parse(map['creation_date']),
      editDate: DateTime.parse(map['edit_date']),
      prepTimeMinutes: map['prep_time_minutes']?.toInt() ?? 0,
      alcoholic: map['alcoholic'] ?? false,
      instruction: map['instruction'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      seasonId: map['season_id'] ?? '',
      drinkTypeId: map['drink_type_id'] ?? '',
      userId: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeCreate.fromJson(String source) => RecipeCreate.fromMap(json.decode(source));
}
