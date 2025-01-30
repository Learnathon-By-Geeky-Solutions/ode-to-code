import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view/test/web/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentView extends StatefulWidget {
  final String categoryId;
  final String classId;
  final String chapterId;
  final String chapterTitle;

  const ContentView({
    required this.categoryId,
    required this.classId,
    required this.chapterId,
    required this.chapterTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final TextEditingController _contentTitleController = TextEditingController();
  final TextEditingController _contentBodyController = TextEditingController();

  // Add Content to Firestore
  Future<void> _addContent() async {
    if (_contentTitleController.text.isNotEmpty &&
        _contentBodyController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryId)
          .collection('classes')
          .doc(widget.classId)
          .collection('chapters')
          .doc(widget.chapterId)
          .collection('contents')
          .add({
        'title': _contentTitleController.text,
        'body': _contentBodyController.text,
      });
      Get.snackbar("Success", "Content added successfully!");
      _contentTitleController.clear();
      _contentBodyController.clear();
      setState(() {});
    } else {
      Get.snackbar("Error", "Both title and content are required!");
    }
  }

  // Fetch Content for a specific chapter
  Future<List<Map<String, String>>> _fetchContents() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('classes')
        .doc(widget.classId)
        .collection('chapters')
        .doc(widget.chapterId)
        .collection('contents')
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'title': doc['title'] as String,
        'body': doc['body'] as String,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _fetchContents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching contents"));
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text("No contents available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final content = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Get.to(() => WebViewScreen(link: content['body'] ?? ''));
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text(content['title'] ?? ''),
                      subtitle: Text(content['body'] ?? ''),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text("Add Content"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _contentTitleController,
                  decoration: const InputDecoration(hintText: "Enter title"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _contentBodyController,
                  decoration: const InputDecoration(hintText: "Enter content"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _addContent();
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
