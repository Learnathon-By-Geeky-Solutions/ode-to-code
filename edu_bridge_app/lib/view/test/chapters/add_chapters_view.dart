import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class AddChapterView extends StatelessWidget {
  final String classId;
  final TextEditingController _chapterNameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AddChapterView({required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Chapter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _chapterNameController,
              decoration: InputDecoration(labelText: "Chapter Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _firestore.collection('chapters').add({
                  'classId': classId,
                  'chapterName': _chapterNameController.text,
                });
                Get.back();
              },
              child: Text("Add Chapter"),
            ),
          ],
        ),
      ),
    );
  }
}
