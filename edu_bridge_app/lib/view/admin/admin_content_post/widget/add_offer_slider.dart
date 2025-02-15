import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddOfferSlider extends StatefulWidget {
  const AddOfferSlider({super.key});

  @override
  State<AddOfferSlider> createState() => _AddOfferSliderState();
}

class _AddOfferSliderState extends State<AddOfferSlider> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child("banners/$fileName.jpg");

      await ref.putFile(File(image.path));
      String imageUrl = await ref.getDownloadURL();

      // Save the image URL in Firestore
      await _firestore.collection("banners").add({"imageUrl": imageUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickAndUploadImage,
      child: Stack(
        children: [
          Image.asset(AssetsPath.sliderCard),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.white),
                  CustomText(
                      text: "Insert a 360x180 banner", color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
