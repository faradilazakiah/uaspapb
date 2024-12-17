import 'package:flutter/material.dart';

class PollingSurveyPage extends StatefulWidget {
  const PollingSurveyPage({super.key});

  @override
  _PollingSurveyPageState createState() => _PollingSurveyPageState();
}

class _PollingSurveyPageState extends State<PollingSurveyPage> {
  final List<Map<String, dynamic>> polls = [
    {
      'question': 'Apa yang harus menjadi prioritas kota tahun ini?',
      'options': ['Infrastruktur', 'Pendidikan', 'Kesehatan', 'Keamanan'],
      'votes': [0, 0, 0, 0],
    },
  ];

  void _addPoll() async {
    String? question;
    List<String> options = [];

    // Dialog untuk memasukkan pertanyaan polling
    await showDialog(
      context: context,
      builder: (context) {
        final questionController = TextEditingController();
        final optionController = TextEditingController();

        return AlertDialog(
          title: const Text("Buat Polling Baru"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: "Pertanyaan"),
                ),
                TextField(
                  controller: optionController,
                  decoration: const InputDecoration(
                      labelText: "Opsi (pisahkan dengan koma)"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                question = questionController.text;
                options = optionController.text.split(',').map((e) => e.trim()).toList();
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (question != null && options.isNotEmpty) {
      setState(() {
        polls.add({
          'question': question,
          'options': options,
          'votes': List.generate(options.length, (index) => 0),
        });
      });
    }
  }

  void _updateVote(int pollIndex, int optionIndex, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        polls[pollIndex]['votes'][optionIndex]++;
      } else if (polls[pollIndex]['votes'][optionIndex] > 0) {
        polls[pollIndex]['votes'][optionIndex]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polling & Survei"),
        backgroundColor: const Color(0xFF00897B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: polls.length,
        itemBuilder: (context, index) {
          final poll = polls[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poll['question'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(poll['options'].length, (optionIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            poll['options'][optionIndex],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () =>
                                  _updateVote(index, optionIndex, false),
                            ),
                            Text(
                              '${poll['votes'][optionIndex]} votes',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () =>
                                  _updateVote(index, optionIndex, true),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPoll,
        backgroundColor: const Color(0xFF00897B),
        child: const Icon(Icons.add),
      ),
    );
  }
}
