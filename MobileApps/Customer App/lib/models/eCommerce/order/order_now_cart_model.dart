class OrderNowCartModel {
  int shopId;
  String shopName;
  int productId;
  double price;
  double discountPrice;
  String productImage;
  String productName;
  String? color;
  String? size;
  OrderNowCartModel({
    required this.shopId,
    required this.shopName,
    required this.productId,
    required this.price,
    required this.discountPrice,
    required this.productImage,
    required this.productName,
    this.color,
    this.size,
  });
}
