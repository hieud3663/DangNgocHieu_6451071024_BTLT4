import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/view/screens/2/form_userinfo.dart';
import 'package:flutter_baitap_chuong4/view/screens/3/form_survey.dart';
import 'package:flutter_baitap_chuong4/view/screens/4/form_Book.dart';
import 'package:flutter_baitap_chuong4/view/screens/5/form_upload_cv.dart';
import 'package:flutter_baitap_chuong4/view/screens/6/form_register_v2.dart';
import '../../../models/dashboard_item.dart';
import '../../../widget/dashboard_card.dart';
import '../1/form_register_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DashboardItem(
        icon: Icons.touch_app,
        iconColor: Colors.blue,
        label: 'Bài 1: Đăng ký tài khoản',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormRegisterScreen()),
        ),
      ),
      DashboardItem(
        icon: Icons.colorize,
        iconColor: Colors.red,
        label: 'Bài 2: Form thông tin cá nhân',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormUserInfoScreen()),
        ),
      ),
      DashboardItem(
        icon: Icons.pan_tool,
        iconColor: Colors.green,
        label: 'Bài 3: Form Survey',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormSurvey()),
        ),
      ),
      DashboardItem(
        icon: Icons.pin,
        iconColor: Colors.orange,
        label: 'Bài 4: Form đặt lịch hẹn',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  FormBook()),
        ),
      ),
      DashboardItem(
        icon: Icons.ads_click,
        iconColor: Colors.purple,
        label: 'Bài 5: Form upload hồ sơ',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormUploadCV()),
        ),
      ),
      DashboardItem(
        icon: Icons.circle,
        iconColor: Colors.cyan,
        label: 'Bài 6: Form đăng ký tài khoản nâng cao',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormRegisterV2()),
        ),
      ),
      // DashboardItem(
      //   icon: Icons.tune,
      //   iconColor: Colors.amber,
      //   label: 'Bài 7: Slider tự tạo',
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const CustomSliderScreen()),
      //   ),
      // ),
      // DashboardItem(
      //   icon: Icons.grid_on,
      //   iconColor: Colors.indigo,
      //   label: 'Bài 8: Gesture Grid',
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const GestureGridScreen()),
      //   ),
      // ),
      // DashboardItem(
      //   icon: Icons.swipe,
      //   iconColor: Colors.pink,
      //   label: 'Bài 9: Swipe hình',
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const SwipeImageScreen()),
      //   ),
      // ),
      // DashboardItem(
      //   icon: Icons.delete_sweep,
      //   iconColor: Colors.brown,
      //   label: 'Bài 10: Kéo xóa item',
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const DismissListScreen()),
      //   ),
      // ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: items.map((item) => DashboardCard(item: item)).toList(),
        ),
      ),
    );
  }
}
