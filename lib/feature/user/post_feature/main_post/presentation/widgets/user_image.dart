import 'package:flutter/material.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/utilts/api_constant.dart';
import '../../../../../../core/utilts/functions.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key,required this.image});

  final String image ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(Routers.profile);
      },
      child: CircleAvatar(
        radius: Constant.width(context) * .013,
        backgroundImage: Functions.getUserImage(image),
      ),
    );
  }
}
