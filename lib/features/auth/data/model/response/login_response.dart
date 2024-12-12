import 'package:peakmart/app/base_response.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';

class LoginResponse extends BaseResponse<LoginEntity> {
  LoginData data;

  LoginResponse({
    required super.status,
    required super.message,
    required super.error,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status']??false,
      message: json['message'],
      error: json['error'],
      data: LoginData(
        email: json['data']['email'],
        userId: json['data']['userId'],
        userName: json['data']['userName'],
      ),
    );
  }

  @override
  LoginEntity toEntity() {
    return LoginEntity(
      email: data.email,
      userId: data.userId,
      userName: data.userName,
    );
  }
}

class LoginData {
  String email;
  String userId;
  String userName;

  LoginData({
    required this.email,
    required this.userId,
    required this.userName,
  });
}
