import 'dart:async';

import 'package:flutter_task_app/view/features/crypto_dashboard/services/api_services.dart';
import 'package:get/get.dart';

enum CoinKey { BTC, ETH, USDT }

extension CoinKeyExt on CoinKey {
  String get coinGeckoId {
    switch (this) {
      case CoinKey.BTC:
        return 'bitcoin';
      case CoinKey.ETH:
        return 'ethereum';
      case CoinKey.USDT:
        return 'tether';
    }
  }

  String get symbol => name;
}

class CryptoController extends GetxController {
  final ApiServices apiServices = ApiServices();

  final selectedCoin = CoinKey.BTC.obs;
  final priceUsd = 0.0.obs;
  final prices7day = <double>[].obs;
  final isLoading = false.obs;
  final error = RxnString();
  RxBool showDropdown = false.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    startAutoRefresh();
  }

  /// Starts the periodic fetch every 10 seconds
  void startAutoRefresh() {
    stopAutoRefresh();
    timer = Timer.periodic(const Duration(seconds: 10), (_) => fetchData());
  }

  @override
  void onClose() {
    stopAutoRefresh();
    super.onClose();
  }

  /// Stops the periodic timer
  void stopAutoRefresh() {
    timer?.cancel();
    timer = null;
  }

  /// fetch data from price and chart APIs method
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;
    try {
      final coinId = selectedCoin.value.coinGeckoId;
      final price = await apiServices.fetchPriceUsd(coinId);
      final chart = await apiServices.fetch7daysChart(coinId);
      priceUsd.value = price;
      prices7day.assignAll(chart);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// change coin method
  void changeCoin(CoinKey coin) {
    selectedCoin.value = coin;
    showDropdown.value = false;
    fetchData();
    startAutoRefresh();
  }

  /// drop down toggle method
  void toggleDropdown() {
    showDropdown.value = !showDropdown.value;
  }
}
