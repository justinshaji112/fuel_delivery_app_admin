import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/scrivce_model.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';
import 'package:image_picker/image_picker.dart';

class ServiceMangementService {
  Stream<List<Service>> getServices() {
    return FireSetup.service.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Service.fromJson(data);
      }).toList();
    });
  }

  

  addService(Service service) async {
    try {
      await FireSetup.service.add(service.toJson());
    } catch (e) {
 throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await FireSetup.service.doc(service.id).update(service.toJson());
    } catch (e) {
       throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  deleteService(String id) async {
    try {
      await FireSetup.service.doc(id).delete();
    } catch (e) {
       throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }
}
