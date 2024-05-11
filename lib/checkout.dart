import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'keranjang.dart';
import 'status.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutPage({required this.cartItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    // Hitung total harga
    double totalPrice = widget.cartItems
        .fold(0, (total, item) => total + (item.price * item.quantity));
    double deliveryFee = 10000; // Biaya kirim di-hardcode
    double totalPayment = totalPrice + deliveryFee;

    // Alamat pengguna (di-hardcode)
    String userAddress = 'Jalan Raya No. 123';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Out',
          style: GoogleFonts.afacad(
            textStyle: TextStyle(
              fontSize: 25,
              color: const Color.fromARGB(255, 174, 35, 35),
              fontWeight: FontWeight.bold, // Add this line for bold text
            ),
          ),
        ),
        backgroundColor:
            Color.fromARGB(255, 255, 255, 255), // Changed app bar color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.red.shade50, // Added container background color
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Alamat Pengiriman',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0), // Changed text color
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              userAddress,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(), // Added divider for visual separation
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(item: widget.cartItems[index]);
              },
            ),
          ),
          Divider(), // Added divider for visual separation
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Harga: Rp ${totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Biaya Kirim: Rp ${deliveryFee.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Total Bayar: Rp ${totalPayment.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                        255, 174, 35, 35), // Changed text color
                  ),
                ),
              ],
            ),
          ),
          Divider(), // Added divider for visual separation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              hint: Text('Pilih Metode Pembayaran'), // Changed hint text
              items: <String>['Tunai', 'E-Wallet']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan fungsi checkout di sini
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OrderAcceptedPage(
                  selectedPaymentMethod:
                      selectedPaymentMethod!, // Mengirimkan metode pembayaran yang dipilih
                  totalPayment: totalPayment, // Mengirimkan total pembayaran
                  cartItems: widget
                      .cartItems, // Mengirimkan daftar makanan yang dipesan
                ),
              ),
              (route) => false, // Menghapus semua halaman di atasnya
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 174, 35, 35), // Changed button background color
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bayar',
              style: TextStyle(color: Colors.white), // Warna teks
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckoutPage(
        cartItems: []), // Passing an empty list as initial cart items
  ));
}
