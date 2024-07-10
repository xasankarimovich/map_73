import 'package:flutter_code/data/models/place_category.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  PlaceModel({
    required this.latLng,
    required this.placeName,
    required this.entrance,
    required this.flatNumber,
    required this.orientAddress,
    required this.stage,
    required this.image,
    this.id,
  });

  final String? id;
  LatLng latLng;
  final String placeName;
  final String entrance;
  final String stage;
  final String flatNumber;
  final String orientAddress;
  final String image;

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      latLng: LatLng(json['lat'], json['lng']),
      placeName: json['placeName'],
      entrance: json['entrance'],
      flatNumber: json['flatNumber'],
      orientAddress: json['orientAddress'],
      stage: json['stage'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': "",
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      'placeName': placeName,
      'entrance': entrance,
      'flatNumber': flatNumber,
      'orientAddress': orientAddress,
      'stage': stage,
      'image': image,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      'placeName': placeName,
      'entrance': entrance,
      'flatNumber': flatNumber,
      'orientAddress': orientAddress,
      'stage': stage,
      'image': image,
    };
  }

  PlaceModel copyWith({
    LatLng? latLng,
    String? placeName,
    String? entrance,
    String? flatNumber,
    String? orientAddress,
    String? stage,
    String? image,
  }) {
    return PlaceModel(
      latLng: latLng ?? this.latLng,
      placeName: placeName ?? this.placeName,
      entrance: entrance ?? this.entrance,
      flatNumber: flatNumber ?? this.flatNumber,
      orientAddress: orientAddress ?? this.orientAddress,
      stage: stage ?? this.stage,
      image: image ?? this.image,
    );
  }

  static PlaceModel initialValue() => PlaceModel(
      latLng: const LatLng(0, 0),
      placeName: "",
      entrance: "",
      flatNumber: "",
      orientAddress: "",
      stage: "",
      image: "");
}
