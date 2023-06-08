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
}
