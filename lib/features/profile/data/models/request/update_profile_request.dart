class UpdateProfileRequest {
  final String userName, email, phone, password;

  UpdateProfileRequest(
      {required this.userName,
      required this.email,
      required this.password,
      required this.phone});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'USER_NAME': userName,
      'EMAIL': email,
      'PHONE': phone,
      'PASSWORD': password,
      'COUNTRY': 'Egypt',
      'GOV': 'eg',
      'CITY': 'tanta',
      'ADDRESS': 'tanta',
    };
  }
}
