import 'package:peakmart/core/entities/base_entity.dart';

class CheckIsSellerEntity extends BaseEntity {
  final bool isSeller;

  CheckIsSellerEntity({required this.isSeller});

  @override
  List<Object?> get props => [];
}
