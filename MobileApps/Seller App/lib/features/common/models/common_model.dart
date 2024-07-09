class CommonResponseModel {
  final bool status;
  final String message;
  final dynamic data;
  CommonResponseModel({
    required this.status,
    required this.message,
    this.data,
  });
}
