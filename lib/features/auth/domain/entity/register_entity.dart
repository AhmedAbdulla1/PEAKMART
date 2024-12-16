import 'package:peakmart/core/entities/base_entity.dart';

class RegisterEntity extends BaseEntity {
  final String email;
  final String userName;
  final String userId;
  final String phoneNumber;

  RegisterEntity(
      { required this.phoneNumber ,required this.email, required this.userName, required this.userId});

  @override
  List<Object?> get props => [email, userName, userId, phoneNumber];
}
