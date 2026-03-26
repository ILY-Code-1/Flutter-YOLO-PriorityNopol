import 'package:get/get.dart';
import '../features/history/bindings/history_binding.dart';
import '../features/history/views/history_view.dart';
import '../features/home/bindings/home_binding.dart';
import '../features/home/views/home_view.dart';
import 'utils/slide_page_transition.dart';

abstract class AppPages {
  static const home = '/home';
  static const history = '/history';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      customTransition: SlidePageTransition(slideUp: false),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: history,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
      customTransition: SlidePageTransition(slideUp: true),
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
}
