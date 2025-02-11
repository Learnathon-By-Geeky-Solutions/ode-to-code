/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';

class CardsView extends StatefulWidget {
  final String categoryId;
  final String classId;
  final String chapterId;

  const CardsView({
    required this.categoryId,
    required this.classId,
    required this.chapterId,
  });

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addCard(String cardTitle, String cardContent) async {
    await _firestore
        .collection('categories')
        .doc(widget.categoryId)
        .collection('classes')
        .doc(widget.classId)
        .collection('chapters')
        .doc(widget.chapterId)
        .collection('cards')
        .add({
      'cardTitle': cardTitle,
      'cardContent': cardContent,
    });
  }

  void _showAddCardDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Card"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Enter card title"),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: "Enter card content"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty &&
                    contentController.text.trim().isNotEmpty) {
                  _addCard(titleController.text.trim(),
                      contentController.text.trim());
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('categories')
            .doc(widget.categoryId)
            .collection('classes')
            .doc(widget.classId)
            .collection('chapters')
            .doc(widget.chapterId)
            .collection('cards')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final cards = snapshot.data!.docs;
          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Card(
                child: ListTile(
                  title: Text(card['cardTitle']),
                  subtitle: Text(card['cardContent']),
                  onTap: () {
                    // Navigate to a detailed view if needed
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
*/
