import 'dart:convert';

import 'package:the_bartender_app/utils/globals.dart';

class Tool {
  String id;
  String name;

  Tool({
    required this.id,
    required this.name,
  });

  Tool copyWith({
    String? id,
    String? name,
  }) {
    return Tool(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['tool_id'] ?? '',
      name: currentLocal?.languageCode == 'de'
          ? map['name_de']
          : map['name'] ?? '',
    );
  }


  factory Tool.fromJson(String source) => Tool.fromMap(json.decode(source));
}
