class ProductDetailModel {
  bool? status;
  String? message;
  ProductData? data;

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }
}

class ProductData {
  int? id;
  String? name;
  String? description;
  dynamic price;
  dynamic oldPrice;
  String? image;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
  }
}
