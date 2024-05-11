import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart'; // Ganti dengan file login page Anda

class OpenApp extends StatefulWidget {
  @override
  _OpenAppState createState() => _OpenAppState();
}

class _OpenAppState extends State<OpenApp> {
  @override
  void initState() {
    super.initState();
    // Timer untuk menunggu beberapa detik sebelum berpindah ke halaman login
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Ganti dengan nama class halaman login Anda
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 174, 35, 35),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan logo atau gambar Baraya Food Anda
            Image.asset('assets/images/logo_baraya.png', width: 350, height: 350),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
