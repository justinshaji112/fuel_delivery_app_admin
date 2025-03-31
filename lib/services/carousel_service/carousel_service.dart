import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/carousel_model.dart';
import 'package:fuel_delivary_app_admin/services/common/upload_image.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';
import 'package:image_picker/image_picker.dart';

class CarouselService {
  getCarousels() async {
    // static CollectionReference<Map<String, dynamic>> carousels =
    //   FirebaseFirestore.instance.collection('carousels');
    try {
      QuerySnapshot querySnapshot = await FireSetup.carousels.get();
      log(querySnapshot.toString());
      return querySnapshot.docs
          .map((e) => CarouselModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

    Future<String> addCarousel(CarouselModel carousel) async {
    try {
      // await FireSetup.carousels.add(carousel.toMap());
      DocumentReference docRef = await FireSetup.carousels.add(carousel.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  removeCarousel(String id) async {
    try {
      await FireSetup.carousels.doc(id).delete();
    } catch (e) {
      return Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  updateCarousel(CarouselModel carousel, XFile? image) async {
    try {
      if (image != null) {
        carousel.image = await ImageService.updateImage(image, carousel.image);
      }
      FireSetup.carousels.doc(carousel.id).update(carousel.toMap());
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }
}
