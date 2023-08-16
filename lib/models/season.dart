import 'dart:convert';

import 'package:the_bartender_app/utils/globals.dart';

class Season {
  String id;
  String name;

  Season({
    required this.id,
    required this.name,
  });

  Season copyWith({
    String? id,
    String? name,
  }) {
    return Season(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Season.fromMap(Map<String, dynamic> map) {
    return Season(
      id: map['season_id'] ?? '',
      name: currentLocal?.languageCode == 'de'
          ? map['name_de']
          : map['name'] ?? '',
    );
  }

  factory Season.fromJson(String source) => Season.fromMap(json.decode(source));
}
