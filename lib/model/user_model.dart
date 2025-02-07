class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final bool? status;
  final List<Address?>? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
}