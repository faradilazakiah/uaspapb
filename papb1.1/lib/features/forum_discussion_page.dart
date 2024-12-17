import 'package:flutter/material.dart';

class ForumDiscussionPage extends StatefulWidget {
  const ForumDiscussionPage({super.key});

  @override
  _ForumDiscussionPageState createState() => _ForumDiscussionPageState();
}

class _ForumDiscussionPageState extends State<ForumDiscussionPage> {
  final List<Map<String, dynamic>> discussions = [
    {
      'topic': 'Bagaimana cara meningkatkan kebersihan lingkungan?',
      'comments': [
        'Meningkatkan jumlah tempat sampah.',
        'Edukasi masyarakat tentang daur ulang.',
      ],
    },
  ];

  final TextEditingController commentController = TextEditingController();
  final TextEditingController topicController = TextEditingController();

  void _addDiscussion() {
    final String newTopic = topicController.text.trim();
    if (newTopic.isNotEmpty) {
      setState(() {
        discussions.add({
          'topic': newTopic,
          'comments': [],
        });
        topicController.clear();
      });
    }
  }

  void _addComment(int index) {
    final String newComment = commentController.text.trim();
    if (newComment.isNotEmpty) {
      setState(() {
        discussions[index]['comments'].add(newComment);
        commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum Diskusi"),
        backgroundColor: const Color(0xFF00897B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input untuk topik baru
            TextField(
              controller: topicController,
              decoration: const InputDecoration(
                labelText: 'Topik Diskusi Baru',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addDiscussion(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addDiscussion,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00897B)),
              child: const Text('Buat Diskusi Baru'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: discussions.length,
                itemBuilder: (context, index) {
                  final discussion = discussions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            discussion['topic'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...discussion['comments'].map<Widget>((comment) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('- $comment'),
                            );
                          }).toList(),
                          const SizedBox(height: 12),
                          // Input untuk menambahkan komentar
                          TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              labelText: 'Tambahkan Komentar',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (_) => _addComment(index),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => _addComment(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00897B),
                            ),
                            child: const Text('Kirim Komentar'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
