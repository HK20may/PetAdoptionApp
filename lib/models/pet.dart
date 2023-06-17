// ignore_for_file: constant_identifier_names

enum Gender { MALE, FEMALE }

class Pet {
  final String species;
  final String name;
  final String description;
  final List images;
  final int age;
  final int price;
  final Gender gender;
  bool? adopted;
  Pet({
    required this.name,
    required this.species,
    required this.description,
    required this.images,
    required this.age,
    required this.price,
    required this.gender,
    this.adopted = false,
  });
}
