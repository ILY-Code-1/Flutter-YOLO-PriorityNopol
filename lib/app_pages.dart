import 'package:get/get.dart';
import 'app_routes.dart';
import 'app/core/utils/slide_page_transition.dart';
import 'app/features/home/bindings/home_binding.dart';
import 'app/features/home/views/home_view.dart';
import 'app/features/history/bindings/history_binding.dart';
import 'app/features/history/views/history_view.dart';
import 'app/features/detection/bindings/detection_binding.dart';
import 'app/features/detection/views/detection_view.dart';
import 'app/features/preview/bindings/preview_binding.dart';
import 'app/features/preview/views/preview_view.dart';
import 'app/features/result/bindings/result_binding.dart';
import 'app/features/result/views/result_view.dart';

abstract class AppPages {
  static const String initial = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      customTransition: SlidePageTransition(slideUp: false),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
      customTransition: SlidePageTransition(slideUp: true),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.detection,
      page: () => const DetectionView(),
      binding: DetectionBinding(),
      customTransition: SlidePageTransition(slideUp: true),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.preview,
      page: () => const PreviewView(),
      binding: PreviewBinding(),
      customTransition: SlidePageTransition(slideUp: true),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.result,
      page: () => const ResultView(),
      binding: ResultBinding(),
      customTransition: SlidePageTransition(slideUp: true),
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
}
