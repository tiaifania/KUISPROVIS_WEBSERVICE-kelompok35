import 'dart:async'; // Import Timer

import 'package:flutter/material.dart';
import 'login.dart'; // Mengimpor halaman login

class OTPAuthenticationPage extends StatefulWidget {
  @override
  _OTPAuthenticationPageState createState() => _OTPAuthenticationPageState();
}

class _OTPAuthenticationPageState extends State<OTPAuthenticationPage> {
  String phoneNumber = '';
  String otp = '';
  bool _isOTPSent = false; // Untuk menentukan apakah OTP sudah dikirim atau belum
  late Timer _timer; // Timer untuk mengatur waktu durasi OTP
  int _otpDuration = 60; // Durasi OTP dalam detik

  @override
  void dispose() {
    _timer.cancel(); // Batalkan timer ketika widget di dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Authentication'),
        backgroundColor: Color.fromARGB(255, 174, 35, 35), // Ubah warna latar belakang app bar menjadi merah
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Nomor Telepon',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)), // Ubah warna teks menjadi putih
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 174, 35, 35)), // Ubah warna garis bawah input field menjadi merah ketika input field aktif
                ),
              ),
            ),
            SizedBox(height: 20),
            if (!_isOTPSent) // Tampilkan tombol Kirim OTP jika OTP belum dikirim
              ElevatedButton(
                onPressed: () {
                  // Kirim OTP ke nomor telepon yang dimasukkan
                  _sendOTP(phoneNumber);
                },
                child: Text('Kirim OTP', style: TextStyle(color: Colors.white)), // Ubah warna teks menjadi putih
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 174, 35, 35), // Ubah warna tombol menjadi merah
                ),
              ),
            if (_isOTPSent) // Tampilkan countdown jika OTP sudah dikirim
              Text(
                'Kode OTP akan berakhir dalam $_otpDuration detik',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)), // Ubah warna teks menjadi putih
              ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 174, 35, 35)), // Ubah warna garis bawah input field menjadi merah ketika input field aktif
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verifikasi OTP yang dimasukkan
                _verifyOTP(otp);
                 Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), // Mengarahkan ke BerandaPage
              (route) => false, // Menghapus semua halaman di atasnya
            );
              },
              child: Text('Verifikasi OTP', style: TextStyle(color: Colors.white)), // Ubah warna teks menjadi putih
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 174, 35, 35), // Ubah warna tombol menjadi merah
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendOTP(String phoneNumber) {
    // Implementasi logika pengiriman OTP
    print('Mengirim OTP ke nomor telepon: $phoneNumber');
    // Aktifkan timer selama 60 detik untuk durasi OTP
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpDuration > 0) {
          _otpDuration--;
        } else {
          _timer.cancel(); // Batalkan timer jika waktu OTP sudah habis
        }
      });
    });
    // Atur status OTP telah dikirim
    setState(() {
      _isOTPSent = true;
    });
  }

  void _verifyOTP(String otp) {
    // Implementasi logika verifikasi OTP
    print('Verifikasi OTP: $otp');
  }
}
