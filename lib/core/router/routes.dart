import 'package:go_router/go_router.dart';
import 'package:stg_frontend/presentation/pages/home/home_page.dart';
import 'package:stg_frontend/presentation/pages/task_page.dart';
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/tasks_page',
      builder: (_, state) {
        return TaskPage(department: state.extra as String,);
      },
    ),
  ],
);
