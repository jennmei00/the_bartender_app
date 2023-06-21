import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'tool_id': id});
    result.addAll({'name': name});
  
    return result;
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['tool_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tool.fromJson(String source) => Tool.fromMap(json.decode(source));
}
