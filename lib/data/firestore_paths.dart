class FirestorePaths {
  static String categoriesCollection() => 'categories';
  static String chaptersCollection(
          String categoryId, String classId, String subjectId) =>
      'categories/$categoryId/classes/$classId/subjects/$subjectId/chapters';
}
