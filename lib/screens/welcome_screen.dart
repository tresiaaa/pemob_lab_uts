import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_progress.dart';
import '../widgets/custom_buttons.dart';
import '../utils/theme_provider.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  final TextEditingController _nameController = TextEditingController();

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final colors = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) {
              return IconButton(
                onPressed: () {
                  notifier.toggleTheme();
                },

                icon: Icon(
                  notifier.themeMode == ThemeMode.light
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              );
            },
          )
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image.asset(
                'assets/images/logo.jpg',
                height: screenHeight * 0.25,
                width: screenWidth * 0.7,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50),

              Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Nama Anda',
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Consumer<UserProgress>(
                builder: (context, progress, child) {
                  return Container(
                    width: screenWidth * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mode Waktu (15 detik)',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: progress.isTimerEnabled,
                          onChanged: (value) {
                            progress.setTimerMode(value);
                          },
                          activeThumbColor: colors.primaryColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              CustomButton(
                text: 'Mulai Kuis',
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    Provider.of<UserProgress>(context, listen: false)
                        .setUsername(_nameController.text.trim());
                    Navigator.of(context).pushNamed('/quiz');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Nama tidak boleh kosong.',
                          style: TextStyle(fontFamily: 'CustomFont'),
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