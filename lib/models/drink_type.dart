class DrinkType {
  String id;
  String name;

  DrinkType({
    required this.id,
    required this.name,
  });

  DrinkType copyWith({
    String? id,
    String? name,
  }) {
    return DrinkType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
