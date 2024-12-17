import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';  // Pastikan WelcomeScreen tersedia

void main() async {
  // Pastikan Flutter sudah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase secara asinkron dan tunggu sampai selesai
  try {
    await Firebase.initializeApp();  // Tanpa opsi manual
    if (kDebugMode) {
      print("Firebase berhasil terhubung");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error saat menghubungkan Firebase: $e");
    }
  }

  // Setelah Firebase siap, jalankan aplikasi
  runApp(const EchoSphereApp());
}

class EchoSphereApp extends StatelessWidget {
  const EchoSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EchoSphere',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF98FF98, // Warna hijau mint khusus
          <int, Color> {
            50: Color(0xFFE1F9E1),
            100: Color(0xFFB3F1B3),
            200: Color(0xFF80E380),
            300: Color(0xFF4DD84D),
            400: Color(0xFF26C926),
            500: Color(0xFF98FF98), // Warna utama
            600: Color(0xFF76C576),
            700: Color(0xFF4CAF4C),
            800: Color(0xFF3C9C3C),
            900: Color(0xFF1D701D),
          },
        ),
      ),
      home: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          // Tampilkan indikator loading sementara Firebase sedang diinisialisasi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Jika ada error dalam inisialisasi Firebase, tampilkan alert dialog
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showErrorDialog(context, snapshot.error.toString());
                  },
                  child: const Text('Retry'),
                ),
              ),
            );
          }

          // Jika Firebase berhasil diinisialisasi, tampilkan WelcomeScreen
          if (snapshot.connectionState == ConnectionState.done) {
            return const WelcomeScreen();
          }

          return const Scaffold(
            body: Center(
              child: Text('Status Koneksi Tidak Dikenali'),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk inisialisasi Firebase
  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();  // Tanpa opsi manual
      if (kDebugMode) {
        print("Firebase berhasil terhubung");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saat menghubungkan Firebase: $e");
      }
      throw Exception("Firebase Initialization Error");
    }
  }

  // Fungsi untuk menampilkan dialog error
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Terjadi kesalahan: $errorMessage'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
