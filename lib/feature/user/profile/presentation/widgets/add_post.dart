import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/base_get_post_state.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/manage_profile_post.dart';

import '../../../../../core/service_locator/service_locator.dart';
import '../../../post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';

class AddPostDialog extends StatefulWidget {
  AddPostDialog({
    super.key,
    required this.textEditingController,
    required this.title,
    this.postId,
    required this.managePostCubit,
  });

  int? postId;
  final TextEditingController textEditingController;
  final String title;
  final ManageProfilePost managePostCubit;

  @override
  _AddPostDialogState createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  Future<void> _pickImage() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          widget.managePostCubit.selectedWebImage = result;
        });
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        widget.managePostCubit.selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final managePostCubit = BlocProvider.of<GetProfilePostCubit>(context);

        return AlertDialog(
          title: Text(widget.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.textEditingController,
                decoration: const InputDecoration(
                  labelText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Add Image'),
                  ),
                  if (widget.managePostCubit.selectedImage != null || widget.managePostCubit.selectedWebImage != null)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.textEditingController.text.isNotEmpty || widget.managePostCubit.selectedImage != null) {
                  if (widget.title == "Update") {
                    widget.managePostCubit.updatePost(widget.postId!);
                  } else {
                    await widget.managePostCubit.addPost();
                  }
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add some content!')),
                  );
                }
              },
              child: Text(widget.title),
            ),
          ],
        );


  }
}

