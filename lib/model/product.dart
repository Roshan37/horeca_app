class Product {
  String name;
  String description;
  String image;
  double price;
  List<String> tags;

  Product({required this.name, required this.description, required this.image, required this.price, required this.tags});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'image': image,
    'price': price,
    'tags': List<dynamic>.from(tags.map((tag) => tag)),
  };
}