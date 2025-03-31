// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
   bool? status;
  final List<Address?>? address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      status: json['status'] as bool,
      address: (json['address'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'address':address==null||address!.isEmpty?[]: address!.map((e) => e?.toMap(),),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      address: map['address'] != null ? List<Address?>.from((map['address'] as List<int>).map<Address>((x) => Address?.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

}

class Address {
  final String phoneNumber;
  final String country;
  final String apartmentUnit;
  final String fullName;
  final String state;
  final String postalCode;
  final String addressType;
  final String streetAddress;
  final String city;

  Address({
    required this.phoneNumber,
    required this.country,
    required this.apartmentUnit,
    required this.fullName,
    required this.state,
    required this.postalCode,
    required this.addressType,
    required this.streetAddress,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      phoneNumber: json['phoneNumber'] as String,
      country: json['country'] as String,
      apartmentUnit: json['apartmentUnit'] as String,
      fullName: json['fullName'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      addressType: json['addressType'] as String,
      streetAddress: json['streetAddress'] as String,
      city: json['city'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'country': country,
      'apartmentUnit': apartmentUnit,
      'fullName': fullName,
      'state': state,
      'postalCode': postalCode,
      'addressType': addressType,
      'streetAddress': streetAddress,
      'city': city,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      phoneNumber: map['phoneNumber'] as String,
      country: map['country'] as String,
      apartmentUnit: map['apartmentUnit'] as String,
      fullName: map['fullName'] as String,
      state: map['state'] as String,
      postalCode: map['postalCode'] as String,
      addressType: map['addressType'] as String,
      streetAddress: map['streetAddress'] as String,
      city: map['city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
