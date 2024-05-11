import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup.dart'; // Mengimpor halaman sign up
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Future<bool> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Berhasil login');
      return true; // Login berhasil
    } else {
      print('Gagal login. Kode status: ${response.statusCode}');
      return false; // Login gagal
    }
  } catch (e) {
    print('Error: $e');
    return false; // Login gagal karena ada error
  }
}

class _LoginPageState extends State<LoginPage> {
  void _handleLogin(BuildContext context) async {
    final username = usernameController.text.toString();
    final password = passwordController.text.toString();
    if (username.isNotEmpty && password.isNotEmpty) {
      final success = await login(username, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('Login gagal. Periksa kembali username dan password Anda.');
      }
    } else {
      print('Username dan password harus diisi!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Baraya Food',
          //style: TextStyle(fontSize: 25, color: Colors.white),
          style: GoogleFonts.afacad(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 174, 35, 35),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kata Sandi',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleLogin(context),
              child: Text(
                'Masuk',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 174, 35, 35),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Daftar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 174, 35, 35),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('No. Kelompok : 35'),
            Text('Nama Anggota kelompok :'),
            Text('1:  2201271, TALITHA FAYARINA ADHIGUNAWAN'),
            Text('2:  2202339, TIA IFANIA NUGRAHANINGTYAS')
          ],
        ),
      ),
    );
  }
}
