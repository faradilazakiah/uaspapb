import 'package:flutter/material.dart';
import 'dashboard_item.dart';
import '../features/report_issue_screen.dart';
import '../features/polling_survey_page.dart';
import '../features/forum_discussion_page.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Impor FirebaseAuth untuk logout
import 'login_screen.dart'; // Pastikan untuk mengimpor halaman Login

void navigateToReport(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ReportIssueScreen()),
  );
}

void navigateToFeedback(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DummyPage(title: "Umpan Balik & Masukan")),
  );
}

void navigateToForum(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ForumDiscussionPage()),
  );
}

void navigateToPolling(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const PollingSurveyPage()),
  );
}

// Fungsi untuk logout
Future<void> _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut(); // Melakukan logout dari Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Arahkan ke halaman login
    );
  } catch (e) {
    print('Logout error: $e');
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF00897B),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF00897B),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app), // Icon untuk logout
            onPressed: () => _logout(context), // Logout ketika ditekan
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2DFDB), Color(0xFFE0F7FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selamat datang di Dashboard!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                children: [
                  DashboardItem(
                    icon: Icons.report_problem,
                    label: 'Pelaporan Masalah',
                    onTap: (context) => navigateToReport(context),
                  ),
                  DashboardItem(
                    icon: Icons.forum,
                    label: 'Forum Diskusi',
                    onTap: (context) => navigateToForum(context),
                  ),
                  DashboardItem(
                    icon: Icons.poll,
                    label: 'Polling & Survei',
                    onTap: (context) => navigateToPolling(context),
                  ),
                  DashboardItem(
                    icon: Icons.feedback,
                    label: 'Umpan Balik & Masukan',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                  DashboardItem(
                    icon: Icons.track_changes,
                    label: 'Pelacakan Laporan',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                  DashboardItem(
                    icon: Icons.notifications,
                    label: 'Notifikasi',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                  DashboardItem(
                    icon: Icons.info,
                    label: 'Akses Informasi',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                  DashboardItem(
                    icon: Icons.school,
                    label: 'Pendidikan & Kesadaran',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                  DashboardItem(
                    icon: Icons.share,
                    label: 'Integrasi Media Sosial',
                    onTap: (context) => {},  // Tidak ada navigasi
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
