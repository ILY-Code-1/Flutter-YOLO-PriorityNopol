import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/widgets/gradient_background.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'history_page.dart';

// MainView adalah "shell" tipis — tugasnya hanya menyiapkan PageView.
// Seluruh logika ada di MainController.
// Seluruh UI ada di HomePage dan HistoryPage.
//
// Diubah menjadi StatefulWidget agar bisa menyimpan _lastBackPress
// untuk fitur "tekan back dua kali untuk keluar".
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // Waktu terakhir tombol back ditekan — null berarti belum pernah
  DateTime? _lastBackPress;

  MainController get controller => Get.find<MainController>();

  void _onPopInvoked(bool didPop, dynamic result) {
    // didPop == true artinya pop sudah berhasil terjadi (tidak perlu ditangani)
    if (didPop) return;

    final now = DateTime.now();
    final isFirstPress = _lastBackPress == null ||
        now.difference(_lastBackPress!) > const Duration(seconds: 2);

    if (isFirstPress) {
      // Tekan pertama → simpan waktu, tampilkan snackbar
      _lastBackPress = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Tekan sekali lagi untuk keluar',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      // Tekan kedua dalam 2 detik → keluar dari aplikasi
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false → Flutter tidak langsung pop, kita tangani manual
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: Scaffold(
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
      ),
    );
  }
}
