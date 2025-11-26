import 'package:get/get.dart';
import 'package:quick_service/screens/provider_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String initial = home;

  static final routes = [
    GetPage(
      name: home,
      page: () => const ProviderListScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
