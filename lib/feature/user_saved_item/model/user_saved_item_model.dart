class UserSavedItemModel {
  final String? id;
  final String createdAt;
  final String userId;
  final String type;
  final String title;
  final String link;
  final String? note;
  final String? number;

  UserSavedItemModel({
    this.id,
    required this.createdAt,
    required this.userId,
    required this.type,
    required this.title,
    required this.link,
    this.note,
    this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'type': type,
      'title': title,
      'link': link,
      'note': note,
    };
  }

  factory UserSavedItemModel.fromMap(Map<String, dynamic> map) {
    return UserSavedItemModel(
      id: map['id']?.toString(),
      createdAt: map['created_at']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      link: map['link']?.toString() ?? '',
      note: map['note']?.toString(),
      number: map['number']?.toString(),
    );
  }
}
