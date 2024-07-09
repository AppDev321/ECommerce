class ShopInfoUpdateModel {
  final String shopName;
  final String shopAddress;
  final String shopDescription;
  const ShopInfoUpdateModel({
    required this.shopName,
    required this.shopAddress,
    required this.shopDescription,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = shopName;
    data['address'] = shopAddress;
    data['description'] = shopDescription;
    return data;
  }
}
