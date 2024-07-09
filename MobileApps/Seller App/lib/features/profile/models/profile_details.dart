class UserAccountDetails {
  UserAccountDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profilePhoto,
    required this.gender,
    required this.dateOfBirth,
    required this.isActive,
    required this.shopStatus,
  });
  late final int id;
  late final String firstName;
  late final String? lastName;
  late final String phone;
  late final String email;
  late final String profilePhoto;
  late final String gender;
  late final String? dateOfBirth;
  late final bool isActive;
  late final String shopStatus;
  late final Shop shop;
  late final List<Banner> banners;

  UserAccountDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'] ?? '';
    phone = json['phone'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'] ?? '';
    isActive = json['is_active'];
    shopStatus = json['shop_status'];
    shop = Shop.fromJson(json['shop']);
    banners =
        List.from(json['banners']).map((e) => Banner.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['profile_photo'] = profilePhoto;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['is_active'] = isActive;
    data['shop_status'] = shopStatus;
    data['shop'] = shop.toJson();
    data['banners'] = banners.map((e) => e.toJson()).toList();
    return data;
  }
}

class Shop {
  Shop({
    required this.id,
    required this.name,
    required this.logo,
    required this.banner,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.offDay,
    required this.prefix,
    required this.estimatedDeliveryTime,
    required this.minOrderAmount,
    required this.shopStatus,
    required this.totalProducts,
    required this.totalCategories,
    required this.rating,
    required this.totalReviews,
    required this.description,
  });
  late final int id;
  late final String name;
  late final String logo;
  late final String banner;
  late final String address;
  late final String openTime;
  late final String closeTime;
  late final List<String> offDay;
  late final String prefix;
  late final int estimatedDeliveryTime;
  late final double minOrderAmount;
  late final String shopStatus;
  late final int totalProducts;
  late final int totalCategories;
  late final double rating;
  late final int totalReviews;
  late final String description;

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
    address = json['address'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    offDay = List.castFrom<dynamic, String>(json['off_day']);
    prefix = json['prefix'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    minOrderAmount = json['min_order_amount'].toDouble();
    shopStatus = json['shop_status'];
    totalProducts = json['total_products'];
    totalCategories = json['total_categories'];
    rating = json['rating'].toDouble();
    totalReviews = json['total_reviews'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    data['banner'] = banner;
    data['address'] = address;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['off_day'] = offDay;
    data['prefix'] = prefix;
    data['estimated_delivery_time'] = estimatedDeliveryTime;
    data['min_order_amount'] = minOrderAmount;
    data['shop_status'] = shopStatus;
    data['total_products'] = totalProducts;
    data['total_categories'] = totalCategories;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['description'] = description;
    return data;
  }
}

class Banner {
  Banner({
    required this.id,
    required this.title,
    required this.thumbnail,
  });
  late final int id;
  late final String title;
  late final String thumbnail;

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
