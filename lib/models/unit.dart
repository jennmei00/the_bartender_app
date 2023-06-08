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
}
