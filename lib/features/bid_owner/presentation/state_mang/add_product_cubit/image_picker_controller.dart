import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  List<XFile> get images => _images;

  Future<List<XFile>> pickMultipleImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      log('Picked ${pickedFiles.length} images');

      return pickedFiles;
    } else {
      return _images;
    }
  }

  void removeImage({required int index}) {
    _images.removeAt(index);
    notifyListeners();
  }

  void addImage() async {
    final List<XFile> addedImages = await pickMultipleImages();
    log("added images length:${addedImages.length}");
    log(" images length1:${_images.length}");
    for (var element in addedImages) {
      if (!_images.any((e) => e.path == element.path)) {
        _images.add(element);
      }
      log("images length:${_images.length}");
    }

    log(" images length2:${_images.length}");

    notifyListeners();
  }

  Future<XFile?> pickSingleImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _images = [pickedFile];
      notifyListeners();
      return pickedFile;
    }
    return pickedFile;
  }

  List<File> getImages() => _images.map((e) => File(e.path)).toList();
}
