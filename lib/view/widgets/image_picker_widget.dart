import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/common/image_picker.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
   ImagePickerWidget({
    super.key,

  
    required this.imageUrl,
    required this.image,
  });


  final String? imageUrl;
   ImageController image;


  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  bool isLoadingImage=false;

  Uint8List? imageData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async{
          isLoadingImage=true;
         try{
          widget.image.image=await pickImage(context);
        
          
         imageData=await widget.image.image?. readAsBytes();}catch(e){
          CustomDialogs.error(context,e.toString());
          rethrow;
         }
         isLoadingImage=false;
         
        },
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageData != null
              ? Image.memory(imageData!,fit: BoxFit.cover,)
              
              : widget.imageUrl != null
                  ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  :isLoadingImage?
                 const Center(child: CircularProgressIndicator(),)
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate, size: 50),
                        Text('Tap to add image'),
                      ],
                    ),
        ),
      );
  }
}
