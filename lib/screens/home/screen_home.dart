import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/homepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _letters = [];
  String _displayedText = '';
  bool _showSubheading = false;

  @override
  void initState() {
    super.initState();
    _letters = "PocketGuard".split('');
    _startLetterAnimation();
  }

  void _startLetterAnimation() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (_displayedText.length < _letters.length) {
        setState(() {
          _displayedText += _letters[_displayedText.length];
        });
      } else {
        timer.cancel();
        setState(() {
          _showSubheading = true;
        });
      }
    });
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2), // Purple Gradient Start
              Color(0xFF4A00E0), // Deep Purple Gradient End
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _navigateToLogin,
                child: Text(
                  _displayedText,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Updated to match the gradient background
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (_showSubheading)
                const Text(
                  "Turning Every Penny into Possibility!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Softer contrast against the background
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
