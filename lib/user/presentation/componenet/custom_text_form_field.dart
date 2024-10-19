import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  bool obscureText;
  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final IconData icons ;

   CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.textEditingController,
        required this.icons,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5.w,left: 5.w,bottom: 1.h,top: 1.h),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * .35,
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: Icon(icons,color: Colors.black,),
          labelText: hintText,
          labelStyle:const TextStyle(
            color: Colors.black87,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
          hintStyle: const TextStyle(color: Colors.black),
          fillColor:Colors.transparent ,
          filled: true,
        ),
      ),
    );
  }
}
