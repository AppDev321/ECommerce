import 'dart:convert';

class OrderFilterModel {
  final int page;
  final int perPage;
  final String? search;
  final String status;
  final String? startDate;
  final String? endDate;
  final String? filterType;
  OrderFilterModel({
    required this.page,
    required this.perPage,
    this.search,
    required this.status,
    this.startDate,
    this.endDate,
    this.filterType,
  });

  OrderFilterModel copyWith({
    int? page,
    int? perPage,
    String? search,
    String? status,
    String? startDate,
    String? endDate,
    String? filterType,
  }) {
    return OrderFilterModel(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      filterType: filterType ?? this.filterType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'perPage': perPage,
      'search': search,
      'order_status': status,
      'start_date': startDate,
      'end_date': endDate,
      'filter_type': filterType,
    };
  }

  factory OrderFilterModel.fromMap(Map<String, dynamic> map) {
    return OrderFilterModel(
      page: map['page'] as int,
      perPage: map['perPage'] as int,
      search: map['search'] != null ? map['search'] as String : null,
      status: map['status'] as String,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
      filterType:
          map['filterType'] != null ? map['filterType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderFilterModel.fromJson(String source) =>
      OrderFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
