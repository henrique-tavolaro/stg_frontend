import 'package:go_router/go_router.dart';
import '../../presentation/pages/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) {
        return const HomePage();
      },
    )
  ],
);
