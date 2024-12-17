import 'package:flutter/material.dart';
import 'reset_password_screen.dart'; // Pastikan mengimpor file yang berisi ResetPasswordScreen

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Kunci untuk form
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Latar belakang biru muda
      appBar: AppBar(
        title: const Text("Lupa Kata Sandi"),
        backgroundColor: const Color(0xFF00796B), // Warna hijau kebiruan untuk AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey, // Mengaitkan kunci dengan form
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Email yang terdaftar',
                  hintStyle: TextStyle(color: Colors.grey), // Warna teks placeholder
                  filled: true,
                  fillColor: Colors.white, // Warna latar belakang input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)), // Sudut membulat
                    borderSide: BorderSide.none, // Menghilangkan garis tepi
                  ),
                ),
                style: const TextStyle(fontSize: 15), // Ukuran font 15
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan email yang terdaftar.'; // Pesan error jika kosong
                  }
                  // Tambahkan validasi format email jika perlu
                  return null; // Valid jika tidak kosong
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Jika validasi berhasil, navigasi ke ResetPasswordScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B), // Warna tombol hijau kebiruan
                ),
                child: const Text('Selanjutnya', style: TextStyle(color: Colors.white)), // Teks tombol berwarna putih
              ),
            ],
          ),
        ),
      ),
    );
  }
}
