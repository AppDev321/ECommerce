class MasterModel {
  MasterModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  MasterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['message'] = message;
    jsonData['data'] = data.toJson();
    return jsonData;
  }
}

class Data {
  Data({
    required this.currency,
    required this.paymentGateways,
    required this.isMultiVendor,
  });
  late final Currency currency;
  late final List<PaymentGateways> paymentGateways;
  late final bool isMultiVendor;
  late final String apLogo;
  late final String appName;
  late final String splashLogo;

  late final ThemeColors themeColors;

  Data.fromJson(Map<String, dynamic> json) {
    currency = Currency.fromJson(json['currency']);
    paymentGateways = List.from(json['payment_gateways'])
        .map((e) => PaymentGateways.fromJson(e))
        .toList();
    isMultiVendor = json['multi_vendor'];
    apLogo = json['app_logo'];
    appName = json['app_name'];
    splashLogo = json['web_logo'];
    themeColors = ThemeColors.fromJson(json['theme_colors']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currency'] = currency.toJson();
    data['multi_vendor'] = isMultiVendor;
    data['app_logo'] = apLogo;
    data['theme_colors'] = themeColors.toJson();
    data['app_name'] = appName;
    data['web_logo'] = splashLogo;
    data['payment_gateways'] = paymentGateways.map((e) => e.toJson()).toList();
    return data;
  }
}

class Currency {
  Currency({
    required this.symbol,
    required this.position,
  });
  late final String symbol;
  late final String position;

  Currency.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['position'] = position;
    return data;
  }
}

class PaymentGateways {
  PaymentGateways({
    required this.id,
    required this.title,
    required this.name,
    required this.logo,
    required this.isActive,
  });
  late final int id;
  late final String title;
  late final String name;
  late final String logo;
  late final bool isActive;

  PaymentGateways.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    logo = json['logo'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['name'] = name;
    data['logo'] = logo;
    data['is_active'] = isActive;
    return data;
  }
}

class ThemeColors {
  final String primaryColor;

  ThemeColors({required this.primaryColor});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['primary_color'] = primaryColor;
    return data;
  }

  factory ThemeColors.fromJson(Map<String, dynamic> json) {
    return ThemeColors(
      primaryColor: json['primary'],
    );
  }
}
