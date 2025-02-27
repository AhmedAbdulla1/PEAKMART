import 'package:peakmart/core/entities/base_entity.dart';

class RegisterEntity extends BaseEntity {
  final String email;
  final String userName;
  final String userId;
  final String phoneNumber;

  const RegisterEntity(
      { required this.phoneNumber ,required this.email, required this.userName, required this.userId});
Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'userId': userId,
    };
  }

  // ✅ تحويل JSON إلى كائن `RegisterEntity`
  factory RegisterEntity.fromJson(Map<String, dynamic> json) {
    return RegisterEntity(
      email: json['email'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      userId: json['userId'],
    );
  }
  @override
  List<Object?> get props => [email, userName, userId, phoneNumber];
}
