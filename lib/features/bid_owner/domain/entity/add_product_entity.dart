import 'package:peakmart/core/entities/base_entity.dart';

class AddProductEntity extends BaseEntity {
  final int productId, categoryId, startingPrice, expectedPrice, periodOfBid;
  final String productName,
      description,
      photoUrl,
      location,
      startDate,
      deliveryDate;

const  AddProductEntity(
      {required this.productId,
      required this.categoryId,
      required this.startingPrice,
      required this.expectedPrice,
      required this.periodOfBid,
      required this.productName,
      required this.description,
      required this.photoUrl,
      required this.location,
      required this.startDate,
      required this.deliveryDate});

  @override
  List<Object?> get props => [
        productId,
        categoryId,
        startingPrice,
        expectedPrice,
        periodOfBid,
        productName,
        description,
        photoUrl,
        location,
        startDate,
        deliveryDate];
}
