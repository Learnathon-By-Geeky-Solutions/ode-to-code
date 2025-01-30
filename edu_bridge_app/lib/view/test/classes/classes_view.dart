import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view/test/subjects/subjectview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassesView extends StatefulWidget {
  final String categoryId;
  final String categoryTitle;

  const ClassesView({
    required this.categoryId,
    required this.categoryTitle,
    super.key,
  });

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  final TextEditingController _classController = TextEditingController();

  Future<void> _addClass() async {
    if (_classController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryId)
          .collection('classes')
          .add({'name': _classController.text});
      Get.snackbar("Success", "Class added successfully!");
      _classController.clear();
      setState(() {});
    }
  }

  Future<List<String>> _fetchClasses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('classes')
        .get();

    return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryTitle)),
      body: FutureBuilder<List<String>>(
        future: _fetchClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching classes"));
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text("No classes available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  onTap: () {
                    Get.to(
                      () => SubjectsView(
                        categoryId: widget.categoryId,
                        classId: snapshot.data![
                            index], // Assume the class ID is the name for now
                        classTitle: snapshot.data![index],
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
            title: const Text("Add Class"),
            content: TextField(
              controller: _classController,
              decoration: const InputDecoration(hintText: "Enter class name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _addClass();
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
