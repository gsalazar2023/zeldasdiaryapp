class Armors {
  int id;
  String name;
  List<String> location;
  String image;

  Armors(this.id, this.name, this.location, this.image);

  factory Armors.fromJson(Map<String, dynamic> json) {
    return Armors(
      json['id'],
      json['name'],
      List<String>.from(json['location']),
      json['image'],
    );
  }
}
