class ApiEndpoints {
  static final ApiEndpoints _singleton = ApiEndpoints._internal();
  ApiEndpoints._internal();
  static ApiEndpoints get instance => _singleton;

  static String baseUrl = "https://api.coingecko.com/api/v3";
  static String price = "$baseUrl/simple/price";
  static String chart = "$baseUrl/coins";
}
