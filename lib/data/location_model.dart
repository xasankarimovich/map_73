class LocationModel {
  final String latitude;
  final String image;
  final String title;

  LocationModel({
    required this.latitude,
    required this.image,
    required this.title,
  });

  static LocationModel initialValue = LocationModel(
    latitude: '',
    image: '',
    title: '',
  );

  LocationModel copyWith({
    String? latitude,
    String? image,
    String? title,
  }) =>
      LocationModel(
          latitude: latitude ?? this.latitude,
          image: image ?? this.image,
          title: title ?? this.title);
}
