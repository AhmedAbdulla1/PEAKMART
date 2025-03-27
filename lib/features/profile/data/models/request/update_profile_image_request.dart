
class UpdateProfileImageRequest {
  final String imagePath;

  UpdateProfileImageRequest({
    required this.imagePath,
  });

  List<Map<String, dynamic>> getFiles() {
    return [
      {
        'fieldName': 'photo ',
        'filePath': imagePath,
        'fileName': imagePath.split('/').last,
      },
    ];
  }
}
