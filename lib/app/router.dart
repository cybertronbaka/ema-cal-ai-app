import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/auth_entry/auth_entry_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: Routes.authEntry.name,
      path: Routes.authEntry.path(),
      pageBuilder:
          (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const AuthEntryPage(),
          ),
    ),
  ],
);
