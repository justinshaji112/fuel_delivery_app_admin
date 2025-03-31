import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/offer_model.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';

class OfferService {
  getOffers() async {
    try {
      QuerySnapshot querySnapshot = await FireSetup.offers.get();
      log(querySnapshot.toString());
      return querySnapshot.docs
          .map((e) => OfferModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  Future<String> addOffer(OfferModel offer) async {
    try {
      // await FireSetup.offers.add(offer.toMap());
      DocumentReference docRef = await FireSetup.offers.add(offer.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  removeOffer(String id) async {
    try {
      await FireSetup.offers.doc(id).delete();
    } catch (e) {
      return Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  updateOffer(OfferModel offer) async {
    try {
      FireSetup.offers.doc(offer.id).update(offer.toMap());
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }
}
