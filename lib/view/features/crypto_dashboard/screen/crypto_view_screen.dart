import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task_app/view/features/crypto_dashboard/controller/crypto_controller.dart';
import 'package:flutter_task_app/view/utils/app_colors.dart';
import 'package:flutter_task_app/view/utils/app_styles.dart';
import 'package:flutter_task_app/view/utils/toast_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CryptoViewScreen extends StatefulWidget {
  const CryptoViewScreen({super.key});

  @override
  State<CryptoViewScreen> createState() => _CryptoViewScreenState();
}

class _CryptoViewScreenState extends State<CryptoViewScreen> {
  late final CryptoController c;

  @override
  void initState() {
    c = Get.put(CryptoController());
    c.fetchData();
    ever(c.error, (msg) {
      if (msg?.isNotEmpty ?? false) {
        ToastServices().showError('Some thing went wrong', context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackTextColor,
          centerTitle: true,
          title: Text(
            'Crypto Prices',
            style: AppStyles.instance.whiteTextStyles(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Obx(() {
          if (c.error.value != null && c.error.value!.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // ToastServices().showError(c.error.value!, context);
            });
          }
          return Container(
            padding: EdgeInsets.fromLTRB(20.r, 40.r, 20.r, 40.r),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Coin',
                      style: AppStyles.instance.headerTextStyles(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: c.toggleDropdown,
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(color: AppColors.greyColor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          c.selectedCoin.value.symbol,
                          style: AppStyles.instance.headerTextStyles(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          c.showDropdown.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                if (c.showDropdown.value)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      children: CoinKey.values.map((coin) {
                        return GestureDetector(
                          onTap: () => c.changeCoin(coin),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            color: c.selectedCoin.value == coin
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.transparent,
                            child: Text(
                              coin.symbol,
                              style: AppStyles.instance.headerTextStyles(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 20.h),
                c.isLoading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        color: Colors.white,
                      )
                    : c.error.value != null
                    ? Text(
                        'Some thing went wrong',
                        style: AppStyles.instance.redTextStyles(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price :',
                            style: AppStyles.instance.headerTextStyles(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '\$${NumberFormat("#,##0.00").format(c.priceUsd.value)}',
                            style: AppStyles.instance.greenTextStyles(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 25.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chart (7 Days)',
                      style: AppStyles.instance.headerTextStyles(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    child: c.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                              color: Colors.white,
                            ),
                          )
                        : c.prices7day.isEmpty
                        ? Center(
                            child: Text(
                              'No chart data available',
                              style: AppStyles.instance.headerTextStyles(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : c.error.value != null
                        ? Center(
                            child: Text(
                              'Some thing went wrong',
                              style: AppStyles.instance.headerTextStyles(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                  getTooltipColor: (LineBarSpot touchedSpot) {
                                    if (touchedSpot.y > 1000) {
                                      return Colors.redAccent;
                                    } else {
                                      return Colors.greenAccent;
                                    }
                                  },
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((spot) {
                                      return LineTooltipItem(
                                        '${spot.y}',
                                        AppStyles.instance.headerTextStyles(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              titlesData: const FlTitlesData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: c.prices7day
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => FlSpot(
                                          e.key.toDouble(),
                                          e.value.toDouble(),
                                        ),
                                      )
                                      .toList(),
                                  isCurved: true,
                                  color: Colors.blue,
                                  barWidth: 1,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.withOpacity(0.3),
                                  ),
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                              radius: 3,
                                              color: Colors.white,
                                              strokeWidth: 1,
                                              strokeColor: Colors.blue,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
