class CartModel {
  bool? status;
  String? message;
  CartData? data;

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<CartItem>? cartItems;

  CartData({this.cartItems});

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((item) {
        cartItems!.add(CartItem.fromJson(item));
      });
    }
  }
}

class CartItem {
  int? id;
  int? quantity;
  Product? product;

  CartItem({this.id, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.inFavorites,
        this.inCart});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].toDouble();
    oldPrice = json['old_price'].toDouble();
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
