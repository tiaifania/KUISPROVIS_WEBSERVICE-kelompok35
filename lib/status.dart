import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'keranjang.dart';

class OrderAcceptedPage extends StatefulWidget {
  final String selectedPaymentMethod;
  final double totalPayment;
  final List<CartItem> cartItems;

  OrderAcceptedPage({
    required this.selectedPaymentMethod,
    required this.totalPayment,
    required this.cartItems,
  });

  @override
  _OrderAcceptedPageState createState() => _OrderAcceptedPageState();
}

class _OrderAcceptedPageState extends State<OrderAcceptedPage> {
  String _status = 'Pesanan Diterima';

  @override
  void initState() {
    super.initState();
    _simulateOrderProcess();
  }

  void _simulateOrderProcess() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _status = 'Pesanan Sedang Disiapkan';
      });
    });
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        _status =
            'Makanan Sudah Siap! Driver akan Mengantarkan Pesanan Anda';
      });
    });
    Future.delayed(Duration(seconds: 9), () {
      setState(() {
        _status = 'Makanan Sudah Sampai, Selamat Menikmati!';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status Pesanan',
          style: GoogleFonts.afacad(
            textStyle: TextStyle(
              fontSize: 25,
              color: const Color.fromARGB(255, 174, 35, 35),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Remove leading back arrow when order is completed
        leading: _status == 'Makanan Sudah Sampai, Selamat Menikmati!'
            ? SizedBox.shrink()
            : null,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simulated order process
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      _status,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Delivery information
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.person, // Change this to the desired icon
                              size: 30, // Adjust the size as needed
                              color: Colors.white, // Adjust the color as needed
                            ),
                            backgroundColor: Color.fromARGB(255, 223, 125, 125), // Adjust the background color as needed
                            radius: 30, // Adjust the radius as needed
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Ujang', // Ganti dengan nama driver yang sesuai
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'D 1114 ZY',
                                // Ganti dengan plat nomor yang sesuai
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Alamat Tujuan: Jalan Raya No. 123',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Daftar makanan yang dipesan
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Daftar Pesanan:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Tampilkan daftar makanan yang dipesan
                      for (var item in widget.cartItems)
                        ListTile(
                          title: Text(item.name),
                          subtitle: Text(
                            'Rp ${item.price * item.quantity}',
                          ), // Harga per item
                        ),
                      // Total bayar
                      SizedBox(height: 8),
                      Text(
                        'Total Bayar: Rp ${widget.totalPayment.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Pembayaran yang dipilih
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Metode Pembayaran:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.selectedPaymentMethod,
                        // Tampilkan metode pembayaran yang dipilih
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Close button when order is completed
                if (_status == 'Makanan Sudah Sampai, Selamat Menikmati!')
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ), // Mengarahkan ke BerandaPage
                          (route) =>
                              false, // Menghapus semua halaman di atasnya
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 174, 35, 35), // Button color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Tutup',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderRejectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Ditolak'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.highlight_off,
              color: const Color.fromARGB(255, 174, 35, 35),
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Maaf, Pesanan Anda Ditolak',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
