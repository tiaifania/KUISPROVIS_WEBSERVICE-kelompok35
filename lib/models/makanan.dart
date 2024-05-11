class Makanan {
  final String title;
  final String description;
  final int price;
  final String img_name;
  final int id;

  Makanan(
      {required this.title,
      required this.description,
      required this.price,
      required this.img_name,
      required this.id});

  factory Makanan.fromJson(Map<String, dynamic> json) {
    return Makanan(
        title: json['title'],
        description: json['description'],
        price: json['price'],
        img_name: json['img_name'],
        id: json['id']);
  }
}

class MakananWithImage {
  final Makanan makanan;
  final String imageUrl;

  MakananWithImage({
    required this.makanan,
    required this.imageUrl,
  });
}
