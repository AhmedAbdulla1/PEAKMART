import 'package:peakmart/core/entities/base_entity.dart';

class EmptyEntity extends BaseEntity {
  final String status;
  final String message;
  final int code;

  const EmptyEntity(
      {required this.status,
        required this.message,
        required this.code}
      );

  @override
  List<Object?> get props => [status, message, code];
}