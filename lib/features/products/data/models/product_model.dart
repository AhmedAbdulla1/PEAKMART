
class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String endDate;
  final int peopleRolledIn;
  final double price;
  final bool isEnded;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.endDate,
    required this.peopleRolledIn,
    required this.price,
    required this.isEnded,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      endDate: json['endDate'],
      peopleRolledIn: json['peopleRolledIn'],
      price: json['price'].toDouble(),
      isEnded: json['isEnded'],
    );
  }
}
