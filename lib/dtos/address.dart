import '../models/province.dart';

class Address {
  final Province province;
  final String address;

  Address({
    required this.province,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return{
      'province':  this.province.toJson(),
      'address': this.address
    };
  }
}