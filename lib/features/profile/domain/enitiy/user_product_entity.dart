import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';

class UserProductEntity extends BaseEntity {
  final List<ProductEntity> data;

  const UserProductEntity({required this.data});

  @override
  List<Object?> get props => data;
}
