import 'package:flutter/material.dart';
import '../view/screens/dashboard/dashboard_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      builder: (context, child) => Stack(
        children: [
          child!,
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 10,
            child: const Text(
              '6451071024 - Đặng Ngọc Hiếu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      home: const DashboardScreen(),
    );
  }
}
