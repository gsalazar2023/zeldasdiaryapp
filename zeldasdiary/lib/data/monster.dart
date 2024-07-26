class Monster {
  String category;
  String desc;
  List<String> drops;
  List<String> location;
  int id;
  String image;
  String name;

  Monster(
      {required this.category,
      required this.desc,
      required this.id,
      required this.image,
      required this.name,
      required this.drops,
      required this.location});

  factory Monster.fromJson(Map<String, dynamic> json) {
    //print('Monster json \n');
    //print(json);
    final dropsJson =
        json['drops'] as List<dynamic>?; // usa 'drops' en lugar de 'locations'
    final List<String> drops = dropsJson != null
        ? List<String>.from(dropsJson.map((item) => item as String))
        : [];

    final locJson = json['common_locations'] as List<dynamic>?;
    final List<String> location = locJson != null
        ? List<String>.from(locJson.map((item) => item as String))
        : [];
    return Monster(
        category: json['category'] as String,
        desc: (json['desc'] as String?) ?? "",
        drops: drops,
        id: json['id'] as int,
        location: location,
        image: json['image'] as String,
        name: json['name'] as String);
  }
}
