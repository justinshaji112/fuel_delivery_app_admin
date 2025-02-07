
import 'package:cloud_firestore/cloud_firestore.dart';

class FireSetup {

  static CollectionReference<Map<String, dynamic>> orders= FirebaseFirestore.instance.collection('orders');
  static CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');


  static CollectionReference<Map<String, dynamic>> service =
      FirebaseFirestore.instance.collection('services');


}
