import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_progress.dart';
import '../widgets/custom_buttons.dart';

// WAJIB 1 & 2: Halaman, Navigasi, StatelessWidget
class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  final TextEditingController _nameController = TextEditingController();

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WAJIB 6: Ukuran Dinamis
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kuis', style: TextStyle(fontFamily: 'CustomFont')),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // WAJIB 4: Aset Gambar
              Image.asset(
                'assets/images/logo.png',
                height: screenHeight * 0.2,
              ),
              const SizedBox(height: 30),
              const Text(
                'Selamat Datang di Kuis Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Input Nama Pengguna
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Nama Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton( // WAJIB 3
                text: 'Mulai Kuis',
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    Provider.of<UserProgress>(context, listen: false)
                        .setUsername(_nameController.text.trim());
                    // WAJIB 2: Navigasi
                    Navigator.of(context).pushNamed('/quiz');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama tidak boleh kosong.')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}