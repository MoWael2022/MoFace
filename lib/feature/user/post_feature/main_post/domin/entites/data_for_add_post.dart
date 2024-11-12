import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For web platform check

import 'package:file_picker/file_picker.dart'; // Add this import
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart'; // For web platform check

class DataForAddPost extends Equatable {
  final String userId;
  final String text;
  final String? image;
  final FilePickerResult? webImage;
  final Color color;

  const DataForAddPost({
    required this.color,
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
          "color": color,
          "image": MultipartFile.fromBytes(imageBytes,
              filename: webImage!.files.single.name),
        };
      }
    } else if (!kIsWeb && image != null && image!.isNotEmpty) {
      // Mobile-specific handling for the image
      return {
        "text": text,
        "userId": userId,
        "color": color,
        "image": await MultipartFile.fromFile(image!),
      };
    }

    // In case no image is provided, return only text and userId
    return {
      "text": text,
      "color": color,
      "userId": userId,
    };
  }

  @override
  List<Object?> get props => [userId, text, image];
}
