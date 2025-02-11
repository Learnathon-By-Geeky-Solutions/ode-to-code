/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class AddClassView extends StatelessWidget {
  final String categoryId;
  final TextEditingController _classNameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AddClassView({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classNameController,
              decoration: InputDecoration(labelText: "Class Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _firestore.collection('classes').add({
                  'categoryId': categoryId,
                  'className': _classNameController.text,
                });
                Get.back();
              },
              child: Text("Add Class"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
