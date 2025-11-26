import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_service/screens/provider_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QuickService',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ProviderListScreen(),
    );
  }
}
