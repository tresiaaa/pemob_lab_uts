import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_progress.dart';
import '../widgets/custom_buttons.dart';
// import '../widgets/text_input_field.dart'; // Kita akan styling TextField secara langsung

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  final TextEditingController _nameController = TextEditingController();

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width; // Untuk lebar TextField

    // Palet warna Rococo (konsisten dengan sebelumnya)
    const Color softPink = Color(0xFFF8BBD0); // Pink muda untuk tombol/aksen
    const Color darkText = Color(0xFF4E342E); // Coklat tua (lebih lembut dari hitam)
    const Color softWhite = Color(0xFFFFF8F8); // Putih-pink (bukan putih bersih)
    const Color hintPink = Color(0xFFF48FB1); // Pink sedikit lebih tua untuk hint

    return Scaffold(
      backgroundColor: softWhite, // Latar belakang putih-pink

      // <<< PERUBAHAN: AppBar KEMBALI, tapi title HILANG
      appBar: AppBar(
        backgroundColor: softPink, // Warna AppBar pink
        elevation: 0, // Opsional: menghilangkan bayangan agar lebih flat

        // <<< PERUBAHAN: Hapus 'title' dan 'centerTitle'
        // title: const Text(
        //   'Aplikasi Kuis',
        //   style: TextStyle(fontFamily: 'CustomFont', fontWeight: FontWeight.bold),
        // ),
        // centerTitle: true,
      ),

      body: Center( // Meng-center-kan semua isi
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Memusatkan vertikal di dalam Column
            children: <Widget>[
              // <<< PERUBAHAN: Tampilkan logo Rococo
              Image.asset(
                'assets/images/logo.jpg', // Pastikan nama file ini sama persis
                height: screenHeight * 0.25, // Ukuran logo yang lebih proporsional
                width: screenWidth * 0.7,
                fit: BoxFit.contain, // Memastikan gambar pas tanpa terpotong
              ),
              const SizedBox(height: 50), // Jarak lebih lebar dari logo ke input

              // Input Nama Pengguna
              Container(
                width: screenWidth * 0.8, // Mengatur lebar TextField agar lebih center
                child: TextField(
                  controller: _nameController,
                  style: TextStyle(fontFamily: 'CustomFont', color: darkText),
                  decoration: InputDecoration(
                    labelText: 'Masukkan Nama Anda',
                    labelStyle: TextStyle(fontFamily: 'CustomFont', color: hintPink),
                    filled: true, // Mengaktifkan pengisian warna latar belakang
                    fillColor: Colors.white.withOpacity(0.8), // Warna latar belakang TextField
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: softPink, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hintPink, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              CustomButton(
                text: 'Mulai Kuis',
                color: softPink, // Warna tombol pink
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    Provider.of<UserProgress>(context, listen: false)
                        .setUsername(_nameController.text.trim());
                    Navigator.of(context).pushNamed('/quiz');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: hintPink, // Latar belakang SnackBar
                        content: Text(
                          'Nama tidak boleh kosong.',
                          style: TextStyle(fontFamily: 'CustomFont', color: Colors.white),
                        ),
                      ),
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