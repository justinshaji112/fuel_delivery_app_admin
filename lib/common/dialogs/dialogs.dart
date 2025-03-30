import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialogs{
  
  CustomDialogs._();

 static error(BuildContext context, String error){
    return AwesomeDialog(context:context, dialogType: DialogType.error,title: "Error", desc: error ).show();
  }
 static success(BuildContext context,String message){
  return AwesomeDialog(context: context, dialogType: DialogType.success, title: "Success", desc:message);
 }


static Future<bool?> deleteAgent(BuildContext context,String title,String subtitle) {

   return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context,false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
             
              Navigator.pop(context,true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }



}