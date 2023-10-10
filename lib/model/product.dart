// this is used only to fetch data

class Product {
  final int id;
  final String name;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        id: json['id'],
        name: json['name'],
        stock: json['stock'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'stock': stock,
      };
}