class CommonResponse {
  final bool isSuccess;
  final String message;
  final dynamic data;
  CommonResponse({
    required this.isSuccess,
    required this.message,
    this.data,
  });
}
