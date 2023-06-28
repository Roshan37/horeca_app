class Product {
  int id;
  String name;
  String description;
  String image;
  int price;
  int weight;
  List<String> tags;
  static String? error;
  int quantity;

  Product({required this.id, required this.name, required this.description, required this.image, required this.price, required this.weight, required this.tags, this.quantity = 1});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image_url'],
      price: json['price'],
      weight: json['weight'],
      tags: List<String>.from(json['tegs']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image_url': image,
    'price': price,
    'weight': weight,
    'tegs': List<dynamic>.from(tags.map((tag) => tag)),
  };

  static withError(String errorMessage){
    error = errorMessage;
  }
}