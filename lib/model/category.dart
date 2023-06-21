class Category {
  int id;
  String name;
  String image;
  List<int> productIds;
  static const listIdsValue = [1,2,3,4,5,6];
  static String? error;

  Category({required this.id, required this.name, required this.image, this.productIds = listIdsValue});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image_url'],
      productIds: [1,2,3,4,5,6],
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