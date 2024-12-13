import 'package:peakmart/core/entities/base_entity.dart';

class LoginEntity extends BaseEntity {
  final String email;
  final String userName;
  final String userId;

  LoginEntity(
      {required this.email, required this.userName, required this.userId});

  @override
  List<Object?> get props => [email, userName, userId];
}
