import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ChangeUserImageDataEnter extends Equatable {
  final String token;
  final String userId;

  final String? image;
  final FilePickerResult? webImage;

  const ChangeUserImageDataEnter(
      {required this.token, this.image, this.webImage,required this.userId});

  Future<Map<String, dynamic>> toMap() async {
    if (kIsWeb && webImage != null && webImage!.files.isNotEmpty) {
      final imageBytes = webImage!.files.single.bytes;
      if (imageBytes != null) {
        // Web-specific image handling using MultipartFile.fromBytes
        return {
          "poster": MultipartFile.fromBytes(imageBytes,
              filename: webImage!.files.single.name),
        };
      }
    } else if (!kIsWeb && image != null && image!.isNotEmpty) {
      // Mobile-specific handling for the image
      return {
        "poster": await MultipartFile.fromFile(image!),
      };
    }

    // In case no image is provided, return only text and userId
    return {
      "poster": '',
    };
  }

  @override
  List<Object?> get props => [
        token,
        image,
        webImage,
      ];
}
