class UpdateProfileRequest {
  final String userName, email, phone, password;
  final String? country, gov, city, address;

  UpdateProfileRequest({
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    this.country,
    this.gov,
    this.city,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'USER_NAME': userName,
      'EMAIL': email,
      'PHONE': phone,
      'PASSWORD': password,
      if (country != null) 'COUNTRY': country,
      if (gov != null) 'GOV': gov,
      if (city != null) 'CITY': city,
      if (address != null) 'ADDRESS': address,
    };
  }
}
