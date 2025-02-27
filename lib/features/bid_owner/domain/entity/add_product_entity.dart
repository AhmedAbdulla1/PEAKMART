import 'package:peakmart/core/entities/base_entity.dart';

class AddProductEntity extends BaseEntity {
  final int productId;
  final List<String> productPhotos;


const  AddProductEntity(
      {required this.productId,
      required this.productPhotos});

  @override
  List<Object?> get props => [
        productId,
       productPhotos];
}
