import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  ImageService._();
  
static Future<String> uploadImageToStorage(XFile image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Uint8List imageList = await image.readAsBytes();

      final storageRef = FireSetup.storage.child("images/$fileName");

      UploadTask uploadTask = storageRef.putData(imageList);

      TaskSnapshot snapshot = await uploadTask;

      String url = await snapshot.ref.getDownloadURL();

   
      return url;
    } catch (e) {
     throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

static Future<void> deleteImage(String url)async{
  FireSetup.storage.storage.refFromURL(url).delete();
  
 }

 static Future<String> updateImage(XFile image,String url)async{
  try{
  String imageUrl=await uploadImageToStorage(image);
  deleteImage(url);

  return imageUrl;

  }catch(e){
    throw Exception(FirebaseExceptionHandler.handleException(e));
  }


 }

}