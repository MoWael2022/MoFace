import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/app_cubit/app_cubit.dart';

class AddPostDialog extends StatefulWidget {
  AddPostDialog({
    super.key,
    required this.textEditingController,
    required this.title,
    this.postId,
  });

  int? postId;
  TextEditingController textEditingController = TextEditingController();
  String title;

  @override
  _AddPostDialogState createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Web-specific image picking
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          BlocProvider.of<AppCubit>(context).selectedWebImage = result;
        });
      }
    } else {
      // Mobile-specific image picking
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        BlocProvider.of<AppCubit>(context).selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    return AlertDialog(
      title: Text('Create Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Description field
          TextField(
            controller: widget.textEditingController,
            decoration: const InputDecoration(
              labelText: 'What\'s on your mind?',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 10),

          // Image picker button
          Row(
            children: [
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Add Image'),
              ),
              if (cubit.selectedImage != null && cubit.selectedWebImage != null)
                const Icon(Icons.check_circle, color: Colors.green),
            ],
          ),
        ],
      ),
      actions: [
        // Cancel button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        // Post button
        ElevatedButton(
          onPressed: () {
            // Handle post submission
            if (widget.textEditingController.text.isNotEmpty ||
                cubit.selectedImage != null) {
              if (widget.title == "Update") {
                cubit.updatePost(widget.postId!);
              } else {
                cubit.addPost();
              }
              print('Description: ${widget.textEditingController.text}');
              print('Image Path: ${cubit.selectedImage?.path}');
              Navigator.pop(context);
            } else {
              // Show error
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
