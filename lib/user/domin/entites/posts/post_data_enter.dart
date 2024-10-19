import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For web platform check

import 'package:file_picker/file_picker.dart'; // Add this import
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For web platform check

class PostDataEnter extends Equatable {
  final String userId;
  final String text;
  final String? image;
  final FilePickerResult? webImage;
  final String token;

  const PostDataEnter({
    required this.token,
    required this.userId,
    required this.text,
    this.image,
    this.webImage,
  });

  Future<Map<String, dynamic>> toMap() async {
    if (kIsWeb && webImage != null && webImage!.files.isNotEmpty) {
      final imageBytes = webImage!.files.single.bytes;
      if (imageBytes != null) {
        // Web-specific image handling using MultipartFile.fromBytes
        return {
          "text": text,
          "userId": userId,
          "image": MultipartFile.fromBytes(imageBytes,
              filename: webImage!.files.single.name),
        };
      }
    } else if (!kIsWeb && image != null && image!.isNotEmpty) {
      // Mobile-specific handling for the image
      return {
        "text": text,
        "userId": userId,
        "image": await MultipartFile.fromFile(image!),
      };
    }

    // In case no image is provided, return only text and userId
    return {
      "text": text,
      "userId": userId,
    };
  }

  @override
  List<Object?> get props => [userId, text, image, token];
}

class PostDataEnterForUpdate extends PostDataEnter {
  final int postId;

  const PostDataEnterForUpdate(
      {required this.postId,
      required super.token,
      required super.userId,
      required super.text,
      super.webImage,
      super.image});
}
