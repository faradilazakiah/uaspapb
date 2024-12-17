import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart'; // Pastikan mengimpor SignupScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Fungsi untuk login menggunakan Firebase
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Mengambil nilai dari controller secara dinamis
        String email = _usernameController.text;
        String password = _passwordController.text;

        // Melakukan otentikasi dengan email dan password menggunakan Firebase Authentication
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Menampilkan SnackBar jika login berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Berhasil!')),
        );

        // Navigasi ke halaman Dashboard setelah berhasil login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } catch (e) {
        print("Error saat login: $e");
        // Menampilkan pesan kesalahan jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Gagal: ${e.toString()}')),
        );
      }
    }
  }

  // Fungsi untuk mengubah status visibilitas password
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    // Pastikan controller dibersihkan saat tidak digunakan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'EchoSphere',
                style: TextStyle(fontSize: 27, color: Colors.teal),
              ),
              const SizedBox(height: 20),
              
              // Form input untuk username/email
              TextFormField(
                controller: _usernameController, // Menyambungkan controller
                decoration: InputDecoration(
                  hintText: 'Username / Email',
                  hintStyle: const TextStyle(color: Colors.teal),
                  errorStyle: const TextStyle(color: Colors.red),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              
              // Form input untuk password
              TextFormField(
                controller: _passwordController, // Menyambungkan controller
                obscureText: !_isPasswordVisible, // Mengontrol visibilitas password
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.teal),
                  errorStyle: const TextStyle(color: Colors.red),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Tombol login
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                ),
                child: const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              
              // Navigasi ke halaman lupa password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text('Lupa Kata Sandi?', style: TextStyle(color: Colors.teal)),
              ),
              
              // Navigasi ke halaman daftar akun
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text('Belum punya akun? Daftar', style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
