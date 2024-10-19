import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../controller/app_cubit/app_cubit.dart';
import '../controller/app_cubit/app_state.dart';
import '../controller/loading_cubit/data_cubit.dart';
import 'add_post.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar(
      {super.key,
      required this.backgroundImage,
      required this.profileImage,
      required this.numberOfFriends,
      required this.username});

  final String username;
  final dynamic profileImage;
  final dynamic backgroundImage;
  final String numberOfFriends;

  Future<void> _pickImage(context) async {
    if (kIsWeb) {
      // Web-specific image picking
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        BlocProvider.of<AppCubit>(context).selectedWebProfileImage = result;
      }
    } else {
      // Mobile-specific image picking
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      BlocProvider.of<AppCubit>(context).selectedProfileImage = image;
    }
  }

  Future<void> _pickBackgroundImage(context) async {
    if (kIsWeb) {
      // Web-specific image picking
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        BlocProvider.of<AppCubit>(context).selectedWebBackgroundImage = result;
      }
    } else {
      // Mobile-specific image picking
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      BlocProvider.of<AppCubit>(context).selectedBackgroundImage = image;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    final dataCubit = BlocProvider.of<DataCubit>(context);
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: Constant.height(context) * .6,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BlocBuilder<AppCubit ,AppState>(
              builder: (context,state) {
                return Container(
                  width: Constant.width(context) * .7,
                  height: Constant.height(context) * .5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: dataCubit.userData!.backgroundImgge.isEmpty
                          ? const NetworkImage(
                              ImagePathManager.defaultProfileImage,
                            )
                          : MemoryImage(base64Decode(dataCubit.userData!.backgroundImgge)) as ImageProvider,
                    ),
                  ),
                );
              }
            ),
            // IconButton for changing or viewing the background image
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () {
                  _showImageOptionsDialog(
                    context,
                    'background',
                    backgroundImage,
                    () async {
                      //Navigator.of(context).pop();
                      //final result = await FilePicker.platform.pickFiles(type: FileType.image);
                      await _pickBackgroundImage(context);
                      await cubit.changeBackgroundImage();

                      // Handle changing the image (e.g., opening image picker)
                    },
                  );
                },
              ),
            ),
            Positioned(
              right: 3,
              top: Constant.height(context) * .43,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: Constant.width(context) * .01,
                            top: Constant.width(context) * .02),
                        child: Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.width(context) * .02,
                          ),
                        ),
                      ),
                      Text(
                        numberOfFriends,
                        style: TextStyle(
                          fontSize: Constant.width(context) * .01,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<AppCubit,AppState>(
                    builder: (context,state) {
                      return CircleAvatar(
                        radius: Constant.width(context) * .052,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: Constant.width(context) * .05,
                          backgroundImage: (dataCubit.userData!.photoImage.isEmpty || dataCubit.userData!.photoImage== "ChQeKDI=")
                              ? const NetworkImage(
                                  ImagePathManager.defaultProfileImage)
                              : MemoryImage(base64Decode(dataCubit.userData!.photoImage)),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              icon:
                                  const Icon(Icons.camera_alt, color: Colors.blue),
                              onPressed: () {
                                _showImageOptionsDialog(
                                  context,
                                  'profile',
                                  profileImage,
                                  () async {
                                    //Navigator.of(context).pop();
                                    await _pickImage(context);
                                    await cubit.changeProfileImage();

                                    // Handle changing the image (e.g., opening image picker)
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog for changing/viewing images
  void _showImageOptionsDialog(
      BuildContext context, String imageType, imageBase64, onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change or View $imageType Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: imageBase64.isEmpty
                    ? const NetworkImage(ImagePathManager.defaultProfileImage)
                    : MemoryImage(base64Decode(imageBase64)) as ImageProvider,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 10),
              Text("Would you like to change or view the $imageType image?"),
            ],
          ),
          actions: <Widget>[
            TextButton(child: Text("Change"), onPressed: onPressed),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
