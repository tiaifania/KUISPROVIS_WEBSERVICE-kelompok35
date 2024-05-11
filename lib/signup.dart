import 'package:flutter/material.dart';
import 'login.dart'; // Mengimpor halaman login
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void signUp(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/users/'),
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
      print('akun terbuat');
    } else {
      print('Gagal membuat akun. Kode status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class _SignUpPageState extends State<SignUpPage> {
  String username = '';
  String password = '';
  bool _passwordVisible =
      false; // Untuk menentukan apakah kata sandi harus ditampilkan atau tidak

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Ikon panah ke belakang
            color: Colors.black, // Warna ikon
          ),
          onPressed: () {
            // Aksi yang ingin dilakukan saat tombol panah kembali ditekan
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage()), // Mengarahkan ke BerandaPage
              (route) => false, // Menghapus semua halaman di atasnya
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Username'),
            SizedBox(height: 10),
            TextField(
              controller: usernameController,
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Kata Sandi'),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText:
                  !_passwordVisible, // Pengaturan apakah kata sandi harus ditampilkan atau tidak
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signUp(usernameController.text.toString(),
                    passwordController.text.toString());
              },
              // onPressed: () {
              //   // Menuju halaman sign up saat tombol "Sign Up" ditekan
              //   Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             LoginPage()), // Mengarahkan ke BerandaPage
              //     (route) => false, // Menghapus semua halaman di atasnya
              //   );
              // },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 174, 35, 35), // Warna latar belakang
              ),
              child: Text(
                'Konfirmasi',
                style:
                    TextStyle(color: Colors.white), // Warna teks menjadi putih
              ),
            ),
          ],
        ),
      ),
    );
  }
}
