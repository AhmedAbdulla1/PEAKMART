class UpdateProfileRequest {
  final String userName, email, phone;

  UpdateProfileRequest(
      {required this.userName, required this.email, required this.phone});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'USER_NAME ': userName,
      'EMAIL': email,
      'PHONE': phone
    };
  }
}
