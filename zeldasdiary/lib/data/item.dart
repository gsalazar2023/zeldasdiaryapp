class Items {
  String category;
  String desc;
  List<String> locations;
  int id;
  String image;
  String name;

  Items(
      {required this.category,
      required this.desc,
      required this.id,
      required this.image,
      required this.name,
      required this.locations});

  factory Items.fromJson(Map<String, dynamic> json) {
    //print('Item json \n');
    //print(json);
    final locJson = json['common_locations'] as List<dynamic>?;
    final List<String> locs = locJson != null
        ? List<String>.from(locJson.map((item) => item as String))
        : [];
    return Items(
        category: json['category'] as String,
        desc: (json['desc'] as String?) ?? "",
        locations: locs,
        id: json['id'] as int,
        image: json['image'] as String,
        name: json['name'] as String);
  }
}

