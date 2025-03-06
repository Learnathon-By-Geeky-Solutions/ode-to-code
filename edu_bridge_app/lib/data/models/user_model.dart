class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String whatYouDo;
  final String? createdAt;
  final String accountType;
  final String? image;
  final String? dateOfBirth;
  final String gender;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.whatYouDo,
    this.createdAt,
    required this.accountType,
    this.image,
    this.dateOfBirth,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'what_you_do': whatYouDo,
      'account_type': accountType, // Renamed for clarity
      'image': image,
      'date_of_birth': dateOfBirth,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      whatYouDo: map['what_you_do'] ?? '',
      createdAt: map['created_at'],
      accountType: map['account_type'] ?? '', // Renamed for consistency
      image: map['image'],
      dateOfBirth: map['date_of_birth'],
      gender: map['gender'] ?? '',
    );
  }

  // CopyWith method
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? whatYouDo,
    String? createdAt,
    String? accountType,
    String? image,
    String? dateOfBirth,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      whatYouDo: whatYouDo ?? this.whatYouDo,
      createdAt: createdAt ?? this.createdAt,
      accountType: accountType ?? this.accountType,
      image: image ?? this.image,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }
}
