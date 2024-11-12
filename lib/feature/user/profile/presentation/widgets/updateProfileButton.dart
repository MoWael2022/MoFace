import 'package:flutter/material.dart';

import '../../../../../core/utilts/api_constant.dart';

class UpdateProfileButton extends StatelessWidget {
  const UpdateProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constant.width(context) * .01),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Dialog(
                  child: Text("hallo"),
                );
              });
        },
        child: const Text("Update Profile"),
      ),
    );
  }
}
