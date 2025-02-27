import 'package:peakmart/core/entities/base_entity.dart';

class ProductEntity extends BaseEntity {
  final int id;
  final String name;
  final List<String> imageUrl;
  final String endDate;
  final int peopleRolledIn;
  final double price;
  final bool isEnded;
  final String description;

  ProductEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.endDate,
    required this.peopleRolledIn,
    required this.price,
    required this.isEnded,
    required this.description,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,name, imageUrl,endDate , isEnded];
}