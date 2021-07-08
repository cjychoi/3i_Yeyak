class ApiResponse {
  int result;
  Map<String, dynamic> data;

  ApiResponse({required this.result, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(result: json["result"], data: json["data"]);
  }
}
