import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configarations.dart';
import 'package:fuel_delivary_app_admin/model/scrivce_model.dart';
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

  uploadImageToStorage(XFile image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Uint8List imageLisst = await image.readAsBytes();

      final storageRef =
          FirebaseStorage.instance.ref().child("images/$fileName");

      UploadTask uploadTask = storageRef.putData(imageLisst);

      TaskSnapshot snapshot = await uploadTask;

      String url = await snapshot.ref.getDownloadURL();

      print('Image path: ${image.path}');
      return url;
    } catch (e) {
      print(e.toString());
    }
  }

  addService(Service service) async {
    try {
      await FireSetup.service.add(service.toJson());
    } catch (e) {
      return e;
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await FireSetup.service.doc(service.id).update(service.toJson());
    } catch (e) {
      print(e);
    }
  }

  deleteService(String id) async {
    try {
      await FireSetup.service.doc(id).delete();
    } catch (e) {
      return e;
    }
  }
}
