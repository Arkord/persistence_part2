class Cat {
  final int? id;
  final String race;
  final String name;
  final String? image;

  Cat({
    this.id,
    required this.race,
    required this.name,
    this.image
  });

  factory Cat.fromMap(Map<String, dynamic> json) => Cat(
    id: json['id'],
    race: json['race'],
    name: json['name'],
    image: json['image'] ?? ""
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'race': race,
      'name': name,
      'image': image
    };
  }

}