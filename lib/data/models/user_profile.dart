class UserProfileModel {
  final String? id;
  final String name;
  final String email;
  final String gender;
  final String whatYouDo;
  final String accountType;
  final String image;
  final String dateOfBirth;

  final String? createdAt;

  UserProfileModel({
    this.id,
    required this.name,
    required this.email,
    required this.whatYouDo,
    required this.accountType,
    required this.image,
    required this.dateOfBirth,
    required this.gender,
    this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'what_you_do': whatYouDo,
      'account_type': accountType,
      'image': image,
      'date_of_birth': dateOfBirth,
      'gender': gender,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      whatYouDo: map['what_you_do'] ?? '',
      accountType: map['account_type'] ?? '',
      image: map['image'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      gender: map['gender'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}
