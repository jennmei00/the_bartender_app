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
}
