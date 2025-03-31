import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OfferModel {
  String? id;
  String name;
  double startingPrice;
  double endingPrice;
  String description;
  double offerPercentage;
  bool status;
  OfferModel({
    required this.id,
    required this.name,
    required this.startingPrice,
    required this.endingPrice,
    required this.description,
    required this.offerPercentage,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'name': name,
      'startingPrice': startingPrice,
      'endingPrice': endingPrice,
      'description': description,
      'offerPercentage': offerPercentage,
      "status": status
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
        id: map['id'] == null ? "" : map["id"] as String,
        name: map['name'] as String,
        startingPrice: map['startingPrice'] as double,
        endingPrice: map['endingPrice'] as double,
        description: map['description'] as String,
        offerPercentage: map['offerPercentage'] as double,
        status: map["status"] as bool);
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
