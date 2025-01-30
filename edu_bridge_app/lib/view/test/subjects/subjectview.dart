import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view/test/chapters/chapters_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsView extends StatefulWidget {
  final String categoryId;
  final String classId;
  final String classTitle;

  const SubjectsView({
    required this.categoryId,
    required this.classId,
    required this.classTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final TextEditingController _subjectController = TextEditingController();

  // Add Subject to Firestore
  Future<void> _addSubject() async {
    if (_subjectController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryId)
          .collection('classes')
          .doc(widget.classId)
          .collection('subjects')
          .add({'name': _subjectController.text});
      Get.snackbar("Success", "Subject added successfully!");
      _subjectController.clear();
      setState(() {});
    }
  }

  // Fetch Subjects for a specific class
  Future<List<String>> _fetchSubjects() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('classes')
        .doc(widget.classId)
        .collection('subjects')
        .get();

    return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.classTitle)),
      body: FutureBuilder<List<String>>(
        future: _fetchSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching subjects"));
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text("No subjects available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  onTap: () {
                    Get.to(
                      ChaptersView(
                        categoryId: widget.categoryId,
                        classId: widget.classId,
                        subjectId: snapshot.data![
                            index], // Assuming the document ID should be used
                        subjectTitle: snapshot
                            .data![index], // Subject title from Firestore
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text("Add Subject"),
            content: TextField(
              controller: _subjectController,
              decoration: const InputDecoration(hintText: "Enter subject name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _addSubject();
                },
                child: const Text("Add"),
              ),
            ],
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
