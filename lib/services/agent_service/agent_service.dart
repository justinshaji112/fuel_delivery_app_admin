import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/agent_model.dart';
import 'package:fuel_delivary_app_admin/services/common/upload_image.dart';
import 'package:fuel_delivary_app_admin/utils/error/firebase_errors.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

class AgentService {
  getAgents() async {
    // static CollectionReference<Map<String, dynamic>> agents =
    //   FirebaseFirestore.instance.collection('agents');
    try {
      QuerySnapshot querySnapshot = await FireSetup.agents.get();
      log(querySnapshot.toString());
      return querySnapshot.docs
          .map((e) => AgentModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  addAgent(AgentModel agent) async {
    try {
          final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:agent.email,
      password: "TemporaryPassword123!", // Firebase requires a password, but the agent will reset it.
    );
    agent.id=userCredential.user?.uid;

  
    await FirebaseAuth.instance.signOut();
    await FireSetup.agents.doc(agent.id).set(agent.toMap());
  
    } catch (e) {
      return Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  removeAgent(String id) async {
    try {
      await FireSetup.agents.doc(id).delete();
    } catch (e) {
      return Exception(FirebaseExceptionHandler.handleException(e));
    }
  }

  updateAgent(AgentModel agent, XFile? image) async {
    try {
      if (image != null) {
        agent.image = await ImageService.updateImage(image, agent.image);
      }
      FireSetup.agents.doc(agent.id).update(agent.toMap());
    } catch (e) {
      throw Exception(FirebaseExceptionHandler.handleException(e));
    }
  }
}
