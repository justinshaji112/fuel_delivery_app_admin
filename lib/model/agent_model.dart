// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgentModel {
  String? id;
  String image;
  String name;

  String email;
  String phone;
  List<String> services;
  bool status;

  AgentModel({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'phone': phone,
      'services': services,
      'status': status,
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
        id: map['id'] != null ? map['id'] as String : null,
        image: map['image'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        phone: map['phone'] as String,
        status: map['status'] as bool,
        services: map["services"] == null
            ? []
            : List<String>.from(map["services"] as List<dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
