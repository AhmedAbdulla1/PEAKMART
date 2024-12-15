// models/CategoryModel_model.dart
class CategoryModel {
  final String title;
  final String imageUrl;

  CategoryModel({required this.title, required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'],
      imageUrl: json['image'],
    );
  }
}
