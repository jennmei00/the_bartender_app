import 'dart:convert';

class User {
  String id;
  String username;
  
  User({
    required this.id,
    required this.username,
  });

  User copyWith({
    String? id,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'user_id': id});
    result.addAll({'username': username});
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
