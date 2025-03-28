
class UpdateProfileImageRequest {
  final String imagePath;
  final String password ;
  UpdateProfileImageRequest({
    required this.password,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() => {'PASSWORD': password};

  List<Map<String, dynamic>> getFiles() {
    return [
      {
        'fieldName': 'photo',
        'filePath': imagePath,
        'fileName': imagePath.split('/').last,
      },
    ];
  }
}
