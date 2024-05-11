import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'checkout.dart';

class CartItem {
  final String image;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<CartItem> cartItems = [
    CartItem(
      image: 'assets/images/ayam_geprek.png',
      name: 'Ayam Geprek',
      price: 25000,
      quantity: 2,
    ),
    CartItem(
      image: 'assets/images/pecel_lele.png',
      name: 'Pecel Lele',
      price: 50000,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: GoogleFonts.afacad(
            textStyle: TextStyle(
              fontSize: 25,
              color: const Color.fromARGB(255, 174, 35, 35),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(item: cartItems[index]);
              },
            ),
            SizedBox(height: 80), // Adjust this height as needed
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(cartItems: cartItems),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 174, 35, 35),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Pesan Sekarang',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.asset(
          item.image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${item.quantity}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text(
          'Harga: Rp ${item.price.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
