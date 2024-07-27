class Armors {
  int id;
  String name;
  List<String> upgradeItems;
  String image;

  Armors(this.id, this.name, this.upgradeItems, this.image);

  factory Armors.fromJson(Map<String, dynamic> json) {
    return Armors(
      json['id'],
      json['name'],
      List<String>.from(json['upgradeItems']),
      json['image'],
    );
  }
}
