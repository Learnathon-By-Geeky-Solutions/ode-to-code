class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String whatYouDo;
  final String accountType;
  final String image;
  final String dateOfBirth;
  final String gender;
  final String? createdAt;

  UserModel({
    this.id,
    required this.fullName,
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
      'full_name': fullName,
      'email': email,
      'what_you_do': whatYouDo,
      'account_type': accountType,
      'image': image,
      'date_of_birth': dateOfBirth,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      whatYouDo: map['what_you_do']?.toString() ?? '',
      accountType: map['account_type']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      dateOfBirth: map['date_of_birth']?.toString() ?? '',
      gender: map['gender']?.toString() ?? '',
      createdAt: map['created_at']?.toString(),
    );
  }
}
