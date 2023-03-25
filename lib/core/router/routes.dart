import 'package:go_router/go_router.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/presentation/pages/home/home_page.dart';
import 'package:stg_frontend/presentation/pages/task_details/task_details_page.dart';

import '../../presentation/pages/department_details/department_details_page.dart';
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) {
        return const HomePage();
      },
      routes: [
        GoRoute(
            path: 'tasks_page',
            builder: (_, state) {
              return DepartmentDetailsPage(department: state.extra as String,);
            },
        ),
        GoRoute(
          path: 'task_details',
          builder: (_, state) {
            return TaskDetailsPage(task: state.extra as TaskModel,);
          },
        ),
      ]
    ),

  ],
);
