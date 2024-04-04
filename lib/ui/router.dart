
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_exchange/ui/views/employer/employer_view.dart';
import 'package:job_exchange/ui/views/login/login_view.dart';
import 'package:job_exchange/ui/views/register/register_employer_view.dart';
import 'package:job_exchange/ui/views/register/register_student_view.dart';
import 'package:job_exchange/ui/widgets/screen_with_header_and_footer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: const ValueKey('home'),
        child: ScreenWithHeaderAndFooter(
          body: Container(
            height: 500,
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('login'),
        child: LoginView(),
      ),
    ),
    GoRoute(
      path: '/register_student',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('register_student'),
        child: RegisterStudentView(),
      ),
    ),
    GoRoute(
      path: '/register_employer',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('register_employer'),
        child: RegisterEmployerView(),
      ),
    ),
    GoRoute(
        path: '/create_job',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: const ValueKey("create_job"),
              child: ScreenWithHeaderAndFooter(
                body: EmployerView(
                  indexSelected: 1,
                  params: convertQuery(query: ""),
                )
              ));
        }),
  ]
);

Map<String, String> convertQuery({required String query}) {
  Map<String, String> params = {};
  query.split("&").forEach((param) {
    List<String> keyValue = param.split("=");
    if (keyValue.length == 2) {
      params[keyValue[0]] = keyValue[1];
    }
  });
  return params;
}