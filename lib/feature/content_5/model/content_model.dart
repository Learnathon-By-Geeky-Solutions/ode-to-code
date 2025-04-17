class ContentModel {
  final int? id;
  final String chaptersId;
  final String number;
  final String name;
  final String? link;
  final String createdAt;
  final String? note;

  ContentModel({
    this.id,
    required this.chaptersId,
    required this.number,
    required this.name,
    this.link,
    required this.createdAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'chapters_id': chaptersId,
      'number': number,
      'name': name,
      'link': link,
      'note': note,
    };
  }

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['id'],
      chaptersId: map['chapters_id']?.toString() ?? '',
      number: map['number']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      link: map['link']?.toString(),
      createdAt: map['created_at']?.toString() ?? '',
      note: map['note']?.toString(),
    );
  }
}
