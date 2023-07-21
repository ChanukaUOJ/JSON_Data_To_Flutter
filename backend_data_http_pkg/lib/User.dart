class User {
  String? name;
  String? age;
  String? image;

  User({this.name, this.age, this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    image = json['image'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json['name'] = name;
    json['age'] = age;
    json['image'] = image;
    return null;
  }
}
