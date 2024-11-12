import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../component/imagePathManager.dart';

class Functions {

  static ImageProvider getUserImage(String image){
    if(image.isEmpty|| image==
        "ChQeKDI="){
      return const NetworkImage(
          ImagePathManager
              .defaultProfileImage);
    }else {
      return MemoryImage(base64Decode(image));
    }

  }
}