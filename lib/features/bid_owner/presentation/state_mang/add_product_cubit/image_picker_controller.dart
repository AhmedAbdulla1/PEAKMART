import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  List<File> get images => _images;
  List<XFile>? pickedFiles = [];
  XFile? pickedFile;
  Future<dynamic> pickMultipleImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      _images = pickedFiles.map((file) => File(file.path)).toList();
      notifyListeners();
      this.pickedFiles = pickedFiles;
    }
    return  this.pickedFiles;
  }

  Future<dynamic> pickSingleImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _images = [File(pickedFile.path)];
      notifyListeners();
      this.pickedFile = pickedFile;
    }
    return this.pickedFile;
  }
}
