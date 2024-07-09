class OrderModel {
  OrderModel({
    required this.id,
    required this.orderCode,
    required this.quantity,
    required this.amount,
    required this.orderStatus,
    required this.createdAt,
    required this.address,
  });
  late final int id;
  late final String orderCode;
  late final int quantity;
  late final double amount;
  late final String orderStatus;
  late final String createdAt;
  late final Address address;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    quantity = json['quantity'];
    amount = json['amount'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['order_code'] = orderCode;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['order_status'] = orderStatus;
    data['created_at'] = createdAt;
    data['address'] = address.toJson();
    return data;
  }
}

class Address {
  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.area,
    required this.flatNo,
    required this.addressType,
    required this.addressLine,
    required this.addressLine2,
    required this.postCode,
    required this.isDefault,
  });
  late final int id;
  late final String name;
  late final String phone;
  late final String area;
  late final String flatNo;
  late final String addressType;
  late final String addressLine;
  late final String addressLine2;
  late final String postCode;
  late final bool isDefault;

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    area = json['area'];
    flatNo = json['flat_no'];
    addressType = json['address_type'];
    addressLine = json['address_line'];
    addressLine2 = json['address_line2'];
    postCode = json['post_code'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['area'] = area;
    data['flat_no'] = flatNo;
    data['address_type'] = addressType;
    data['address_line'] = addressLine;
    data['address_line2'] = addressLine2;
    data['post_code'] = postCode;
    data['is_default'] = isDefault;
    return data;
  }
}
