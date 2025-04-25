import 'dart:io';

import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IClassRepository {
  Future<String?> uploadClassImage(File imageFile);
  Future<bool> addClass(ClassModel classModel);
  Future<List<ClassModel>> fetchClassesByCategoryId(String categoryId);
}
