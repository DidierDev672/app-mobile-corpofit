class BasicData {
  final int id;
  final String name;
  final double height;

  final double weight;
  final String gender;

  final DateTime birthDate;
  final String country;
  final String city;
  final String address;

  final String region;
  final DateTime createdAt;

  BasicData({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.gender,
    required this.birthDate,
    required this.country,
    required this.city,
    required this.address,
    required this.region,
    required this.createdAt,
  });

  BasicData copyWith({
    int? id,
    String? name,
    double? height,
    double? weight,
    String? gender,
    DateTime? birthDate,
    String? country,
    String? city,
    String? address,
    String? region,
    DateTime? createdAt,
  }) {
    return BasicData(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      country: country ?? this.country,
      city: city ?? this.city,
      address: address ?? this.address,
      region: region ?? this.region,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
