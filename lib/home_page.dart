import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/makanan.dart';
import 'keranjang.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedFoodIndex = -1;
  late List<MakananWithImage> listMakananWithImages;

  @override
  void initState() {
    super.initState();
    getDataWithImages();
  }

  Future<void> getDataWithImages() async {
    try {
      final response = await http.get(
        Uri.parse('http://146.190.109.66:8000/items/?skip=0&limit=100'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZheWF0aWEiLCJleHAiOjE3MTU0NzIxOTl9.7-h1gwn49WWLdR5YIoXfM6S_3DG4OaCqXHvhe6w-L1o',
        },
      );

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Makanan> makanan = it.map((e) => Makanan.fromJson(e)).toList();

        List<MakananWithImage> makananWithImages = [];

        for (var i = 0; i < makanan.length; i++) {
          final imageResponse = await http.get(
            Uri.parse(
                'http://146.190.109.66:8000/items_image/${i + 1}'), // Menggunakan indeks makanan sebagai ID
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZheWF0aWEiLCJleHAiOjE3MTU0NzIxOTl9.7-h1gwn49WWLdR5YIoXfM6S_3DG4OaCqXHvhe6w-L1o',
            },
          );

          if (imageResponse.statusCode == 200) {
            final imageUrl = imageResponse.body;
            print(
                'Image Response: $imageResponse'); // Pernyataan print untuk mencetak respons dari server
            print('Image URL: $imageUrl');
            makananWithImages
                .add(MakananWithImage(makanan: makanan[i], imageUrl: imageUrl));
          } else {
            throw Exception(
                'Failed to load image: ${imageResponse.statusCode}');
          }
        }

        setState(() {
          listMakananWithImages = makananWithImages;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 174, 35, 35),
        title: Text(
          'Beranda',
          style: GoogleFonts.afacad(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              // Aksi yang ingin dilakukan saat ikon keranjang diklik
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 224, 224),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Cari Makanan',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: constraints.maxWidth > 200 ? 280 : 200,
                    ),
                    itemCount: listMakananWithImages.length,
                    itemBuilder: (_, index) {
                      final makanan = listMakananWithImages[index].makanan;
                      final imageUrl = listMakananWithImages[index].imageUrl;
                      return GestureDetector(
                        onTap: () {
                          _showFoodDetails(makanan);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color.fromARGB(255, 165, 36, 36),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ClipRRect(
                              //   borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(12.0),
                              //     topRight: Radius.circular(12.0),
                              //   ),
                              //   child: Image.asset(
                              //     //gridMap.elementAt(index)['images'],
                              //     package["images"],
                              //     fit: BoxFit.cover,
                              //     width: double.infinity,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      makanan.title,
                                      style: GoogleFonts.afacad(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Rp${makanan.price}",
                                      style: GoogleFonts.afacad(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(CupertinoIcons.cart),
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFoodDetails(Makanan makanan) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  makanan.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Harga: Rp${makanan.price}",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  makanan.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
