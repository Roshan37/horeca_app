class Category {
  int id;
  String name;
  String image;
  static String? error;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': image,
  };

  static withError(String errorMessage){
    error = errorMessage;
  }
}