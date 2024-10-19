import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../global_resources/imagePathManager.dart';

class Functions {

  static getUserImage(String image){
    image.isEmpty ||
        image==
            "ChQeKDI="
        ?const NetworkImage(
        ImagePathManager
            .defaultProfileImage)
        : MemoryImage(base64Decode(image));
  }
}