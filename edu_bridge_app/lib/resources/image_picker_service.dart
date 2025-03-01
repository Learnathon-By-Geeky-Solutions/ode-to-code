import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Pick an image from gallery and upload it to Firebase Storage
  Future<String> pickImage({required String folderName}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the image to Firebase Storage
      File imageFile = File(pickedFile.path);
      String fileName = pickedFile.name;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('$folderName/$fileName')
          .putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl; // Return the image URL
    }
    return ''; // Return empty string if no image was picked
  }
}
