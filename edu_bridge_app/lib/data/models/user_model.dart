class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String whatYouDo;
  final String createdAt;
  final bool isAdmin;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.whatYouDo,
    required this.createdAt,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'what_you_do': whatYouDo,
      'created_at': createdAt,
      'is_admin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      whatYouDo: map['what_you_do'] ?? '',
      createdAt: map['created_at'] ?? '',
      isAdmin: map['is_admin'] ?? false,
    );
  }
}
