import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';

class UserService {
  getUsers() async {
    try {
      QuerySnapshot querySnapshot = await FireSetup.users.get();
      log(querySnapshot.toString());
      return querySnapshot.docs
          .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  Future<String> addUser(UserModel user) async {
    try {
      // await FireSetup.users.add(user.toMap());
      DocumentReference docRef = await FireSetup.users.add(user.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  removeUser(String id) async {
    try {
      await FireSetup.users.doc(id).delete();
    } catch (e) {
      return Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  updateUser(UserModel user) async {
    try {
      FireSetup.users.doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }
}
