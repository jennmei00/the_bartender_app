import 'dart:convert';

import 'package:the_bartender_app/utils/globals.dart';

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

  factory DrinkType.fromMap(Map<String, dynamic> map) {
    return DrinkType(
      id: map['drink_type_id'] ?? '',
      name: currentLocal?.languageCode == 'de'
          ? map['name_de']
          : map['name'] ?? '',
    );
  }

  factory DrinkType.fromJson(String source) =>
      DrinkType.fromMap(json.decode(source));
}
