import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/gradient_background.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'history_page.dart';

// MainView adalah "shell" tipis — tugasnya hanya menyiapkan PageView.
// Seluruh logika ada di MainController.
// Seluruh UI ada di HomePage dan HistoryPage.
class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: PageView(
          // PageController dari MainController — ini jembatan antara
          // tombol/arrow di dalam page dengan pergerakan PageView
          controller: controller.pageController,

          // Scroll vertikal seperti anchor web
          scrollDirection: Axis.vertical,

          // Kedua page menerima controller yang sama
          // sehingga bisa saling memanggil goToHistory() / goToHome()
          children: [
            HomePage(controller: controller),
            HistoryPage(controller: controller),
          ],
        ),
      ),
    );
  }
}
