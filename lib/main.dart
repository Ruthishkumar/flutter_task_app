import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/features/crypto_dashboard/controller/crypto_controller.dart';
import 'view/features/crypto_dashboard/screen/crypto_view_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CryptoController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 805),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const CryptoViewScreen(),
        );
      },
    );
  }
}
