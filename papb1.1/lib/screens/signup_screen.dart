import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});


  @override
  _SignupScreenState createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  // Fungsi untuk signup menggunakan Firebase
  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ambil nilai dari controller
        String email = _emailController.text;
        String password = _passwordController.text;


        // Membuat pengguna baru menggunakan Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );


        // Menampilkan SnackBar jika signup berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun Berhasil Dibuat!')),
        );


        // Navigasi ke halaman Login setelah sukses signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Menangani kesalahan saat signup
    String errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Email sudah terdaftar';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Password terlalu lemah';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email tidak valid';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }


  @override
  void dispose() {
    // Pastikan controller dibersihkan saat tidak digunakan
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Latar belakang biru muda
      appBar: AppBar(
        title: const Text("Buat Akun"),
        backgroundColor: const Color(0xFF00897B), // Warna hijau kebiruan untuk AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk teks
            children: [
              // Input Nama Lengkap
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Nama Lengkap',
                  hintStyle: TextStyle(color: Color(0xFF004D40)), // Warna hint abu-abu gelap
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none, // Menghilangkan garis tepi
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Lengkap tidak boleh kosong';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 15), // Ukuran font
              ),
              const SizedBox(height: 10),
              
              // Input Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Color(0xFF004D40)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),


              // Input Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xFF004D40)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  // Validasi umum untuk email
                  if (!value.contains('@')) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),


              // Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFF004D40)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),


              // Input Konfirmasi Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Konfirmasi Password',
                  hintStyle: TextStyle(color: Color(0xFF004D40)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),


              // Tombol Buat Akun
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B), // Warna tombol hijau kebiruan
                ),
                child: const Text('Buat Akun', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
