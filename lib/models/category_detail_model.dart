class CategoryDetailModel {
  bool? status;
  String? message;
  Data? data;

  CategoryDetailModel({this.status, this.message, this.data});

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<Product>? products;

  Data({this.products});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Product> productsList = list.map((i) => Product.fromJson(i)).toList();

    return Data(
      products: productsList,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final double oldPrice;
  final String image;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price']?.toDouble() ?? 0.0,
      image: json['image'],
      discount: json['discount']?.toDouble() ?? 0.0,
    );
  }
}


