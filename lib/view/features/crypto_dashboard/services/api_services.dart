import 'package:dio/dio.dart';
import 'package:flutter_task_app/view/api_clients/api_endpoints.dart';
import 'package:flutter_task_app/view/api_clients/api_instance.dart';

class ApiServices {
  /// fetch price data method
  Future<double> fetchPriceUsd(String coinId) async {
    Response response = await ApiInstance().dio.get(
      '${ApiEndpoints.price}?ids=$coinId&vs_currencies=usd',
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return (data[coinId]['usd'] as num).toDouble();
    } else {
      throw Exception('Failed to load price');
    }
  }

  /// fetch 7 days chart method
  Future<List<double>> fetch7daysChart(String coinId) async {
    Response response = await ApiInstance().dio.get(
      '${ApiEndpoints.chart}/$coinId/market_chart?vs_currency=usd&days=7',
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final prices = (data['prices'] as List)
          .map((e) => (e[1] as num).toDouble())
          .toList();
      return prices;
    } else {
      throw Exception('Failed to load chart data');
    }
  }
}
