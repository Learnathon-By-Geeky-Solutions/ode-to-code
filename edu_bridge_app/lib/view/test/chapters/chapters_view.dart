import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view/test/content/content_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChaptersView extends StatefulWidget {
  final String categoryId;
  final String classId;
  final String subjectId; // Added to pass subject identifier
  final String subjectTitle; // Added to display subject title

  const ChaptersView({
    required this.categoryId,
    required this.classId,
    required this.subjectId,
    required this.subjectTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView> {
  final TextEditingController _chapterController = TextEditingController();

  // Add Chapter to Firestore
  Future<void> _addChapter() async {
    if (_chapterController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryId)
          .collection('classes')
          .doc(widget.classId)
          .collection('subjects')
          .doc(widget.subjectId)
          .collection('chapters')
          .add({'name': _chapterController.text});
      Get.snackbar("Success", "Chapter added successfully!");
      _chapterController.clear();
      setState(() {});
    }
  }

  // Fetch Chapters for a specific subject
  Future<List<String>> _fetchChapters() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('classes')
        .doc(widget.classId)
        .collection('subjects')
        .doc(widget.subjectId)
        .collection('chapters')
        .get();

    return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subjectTitle)),
      body: FutureBuilder<List<String>>(
        future: _fetchChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching chapters"));
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text("No chapters available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  onTap: () {
                    Get.to(() => ContentView(
                          categoryId: widget.categoryId,
                          classId: widget.classId,
                          chapterId: snapshot
                              .data![index], // Pass the chapter identifier
                          chapterTitle: snapshot.data![index],
                        ));
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
            title: const Text("Add Chapter"),
            content: TextField(
              controller: _chapterController,
              decoration: const InputDecoration(hintText: "Enter chapter name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _addChapter();
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
