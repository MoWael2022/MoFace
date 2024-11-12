import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconComponent extends StatelessWidget {
  const IconComponent({required this.onPressed,required this.icon,super.key});

  final VoidCallback onPressed ;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        child: Icon(icon),
      ),

    );
  }
}
