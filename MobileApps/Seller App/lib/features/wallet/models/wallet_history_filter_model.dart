import 'dart:convert';

class WalletHistoryFilterModel {
  int page;
  int perPage;
  String? filterType;
  WalletHistoryFilterModel({
    required this.page,
    required this.perPage,
    this.filterType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'perPage': perPage,
      'filter_type': filterType,
    };
  }

  factory WalletHistoryFilterModel.fromMap(Map<String, dynamic> map) {
    return WalletHistoryFilterModel(
      page: map['page'] as int,
      perPage: map['perPage'] as int,
      filterType:
          map['filter_type'] != null ? map['filter_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletHistoryFilterModel.fromJson(String source) =>
      WalletHistoryFilterModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
