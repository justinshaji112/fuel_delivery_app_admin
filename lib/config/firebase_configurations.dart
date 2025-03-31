import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireSetup {
  static final Reference storage = FirebaseStorage.instance.ref();

  static CollectionReference<Map<String, dynamic>> orders =
      FirebaseFirestore.instance.collection('orders');
  static CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference<Map<String, dynamic>> service =
      FirebaseFirestore.instance.collection('services');

  static CollectionReference<Map<String, dynamic>> agents =
      FirebaseFirestore.instance.collection('agents');
  static CollectionReference<Map<String, dynamic>> offers =
      FirebaseFirestore.instance.collection('offers');
  static CollectionReference<Map<String, dynamic>> carousels =
      FirebaseFirestore.instance.collection('carousels');
}
