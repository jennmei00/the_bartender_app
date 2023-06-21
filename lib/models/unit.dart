import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'unit_id': id});
    result.addAll({'name': name});
  
    return result;
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['unit_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));
}
