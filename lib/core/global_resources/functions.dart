import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Dialogs {

  static void errorAwesomeDialog (context,String desc){
    AwesomeDialog(
      width: MediaQuery.of(context).size.width * .5,
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: "Error",
        desc: desc,
        btnCancelOnPress: () {},
        btnOk: ElevatedButton(
          onPressed: (){},
          child: const Text("Retry"),
        )
    ).show();
  }

}

