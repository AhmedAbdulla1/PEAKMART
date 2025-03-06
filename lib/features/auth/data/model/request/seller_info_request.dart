import 'dart:developer';
import 'dart:io';

import 'package:peakmart/core/requests/base_request.dart';


class SellerInfoRequest extends BaseRequest {
  final String fullName ;
  final String idNumber ;
  final String iban;
  final File idImage;
  final File ibanImage;


  SellerInfoRequest(
      {required this.fullName, required this.idNumber, required this.iban, required this.idImage, required this.ibanImage});

  @override
  void printRequest() {
    log("fullName: $fullName,  idNumber: $idNumber, city name: $iban");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "id_number": idNumber,
      // "id_img ": fullName,
      "iban": iban,
      // "iban_img ":fullName ,
    };
  }

  List<Map<String,dynamic>> getFiles(){
    return [
      {
        'fieldName': 'id_img',
        'filePath':idImage.path,
        'fileName': idImage.path.split('/').last,
      },
      {
        'fieldName': 'iban_img',
        'filePath': ibanImage.path,
        'fileName': ibanImage.path.split('/').last,
      },
    ];
  }
}
