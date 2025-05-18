import 'package:peakmart/core/entities/base_entity.dart';

class ProductEntity extends BaseEntity {
  final int id;
  final String name;
  final List<String> imageUrl;
  final String? endDate, status;
  final String? startingPrice, expectedPrice, startDate, createdAt;
  final int? peopleRolledIn, periodOfBid, catId, userId;
  final double price;
  final bool isEnded;
  final String description;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.endDate,
      required this.status,
      required this.startingPrice,
      required this.expectedPrice,
      required this.startDate,
      required this.createdAt,
      required this.peopleRolledIn,
      required this.periodOfBid,
      required this.catId,
      required this.userId,
      required this.price,
      required this.isEnded,
      required this.description});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        endDate,
        isEnded,
        status,
        startingPrice,
        expectedPrice,
        startDate,
        createdAt,
        peopleRolledIn,
        periodOfBid,
        catId,
        userId,
        price,
        description
      ];
}