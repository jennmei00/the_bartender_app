import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
  
    return result;
  }

  factory Season.fromMap(Map<String, dynamic> map) {
    return Season(
      id: map['season_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Season.fromJson(String source) => Season.fromMap(json.decode(source));

}
