import 'dart:convert';

import 'package:the_bartender_app/utils/globals.dart';

class Unit {
  String id;
  String name;

  Unit({
    required this.id,
    required this.name,
  });

  Unit copyWith({
    String? id,
    String? name,
  }) {
    return Unit(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['unit_id'] ?? '',
      name: currentLocal?.languageCode == 'de'
          ? map['name_de']
          : map['name'] ?? '',
    );
  }

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));
}
