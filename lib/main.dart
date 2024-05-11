import 'package:flutter/material.dart';
import 'package:kuis2/home_page.dart';
import 'package:kuis2/openapp.dart';
// import 'package:google_fonts/google_fonts.dart'; // Import dari Google Fonts
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baraya Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.nunitoTextTheme(), // Menggunakan Nunito font untuk text theme
      ),
      home: LoginPage(), // Mengatur halaman utama ke PilihPembayaran
    );
  }
}
