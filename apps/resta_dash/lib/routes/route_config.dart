import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resta_dash/app_root.dart';
import 'package:resta_dash/features/auth/view/login_view.dart';
import 'package:resta_dash/features/auth/view/sign_up_view.dart';
import 'package:resta_dash/features/cart/view/cart_summary_view.dart';
import 'package:resta_dash/features/home/view/home_view.dart';
import 'package:resta_dash/features/home/view/item_details.dart';
import 'package:resta_dash/features/onboarding/controller/onboarding_ctrl.dart';
import 'package:resta_dash/features/onboarding/view/onboarding_view.dart';
import 'package:resta_dash/features/profile/view/profile_view.dart';
import 'package:resta_dash/features/settings/view/language_view.dart';
import 'package:resta_dash/features/settings/view/settings_view.dart';

import '../main.export.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);
String rootPath = RPaths.home.path;
final routerProvider = NotifierProvider<AppRouter, GoRouter>(AppRouter.new);

class AppRouter extends Notifier<GoRouter> {
  final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');

  // final _shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

  GoRouter _appRouter(RouteRedirect? redirect) {
    return GoRouter(
      navigatorKey: _rootNavigator,
      redirect: redirect,
      initialLocation: rootPath,
      routes: [
        ShellRoute(
          routes: _routes,
          builder: (_, s, c) => AppRoot(key: s.pageKey, child: c),
        ),
      ],
      errorBuilder: (_, state) => ErrorRoutePage(error: state.error?.message),
    );
  }

  /// The app router list
  List<RouteBase> get _routes => [
    AppRoute(RPaths.underMaintenance, (_) => const MaintenancePage()),
    AppRoute(RPaths.needSubscription, (_) => const NoSubscriptionPage()),
    AppRoute(RPaths.featureUnavailable, (_) => const FeatureUnavailablePage()),

    //! auth
    AppRoute(RPaths.login, (_) => const LoginView()),
    AppRoute(RPaths.signUp, (_) => const SignUpView()),

    //! onboarding
    AppRoute(RPaths.onboarding, (_) => const OnboardingView()),

    //! home
    AppRoute(RPaths.home, (_) => const HomeView()),
    AppRoute(RPaths.itemDetails(':id'), (s) => ItemDetailsView(id: s.pathParameters.parseInt('id'))),
    AppRoute(RPaths.cartSummary, (_) => const CartSummaryView()),
    AppRoute(RPaths.profile, (_) => const ProfileView()),

    //! settings
    AppRoute(RPaths.settings, (_) => const SettingsView()),
    AppRoute(RPaths.language, (_) => const LanguageView()),
  ];

  @override
  GoRouter build() {
    Ctx._key = _rootNavigator;
    Toaster.navigator = _rootNavigator;
    // final isLoggedIn = ref.watch(authCtrlProvider);

    final event = ref.watch(eventCtrlProvider);
    final showOnboard = ref.watch(onboardingCtrlProvider);

    FutureOr<String?> redirectLogic(ctx, GoRouterState state) async {
      final current = state.uri.toString();
      cat(current, 'route redirect');

      final isForced = state.uri.queryParameters.parseBool('forced');

      if (showOnboard) return RPaths.onboarding.path;

      // if (!isLoggedIn) {
      //   cat('NOT LOGGED IN', 'route');
      //   if (current.contains(RPaths.login.path)) return null;
      //   return RPaths.login.path;
      // }

      if (isForced) return null;

      final eventPath = event.path;
      if (eventPath != null) {
        cat('Event path: $eventPath', 'route');
        return eventPath;
      }

      return null;
    }

    return _appRouter(redirectLogic);
  }
}

class Ctx {
  const Ctx._();
  static GlobalKey<NavigatorState>? _key;
  static BuildContext? get tryContext => _key?.currentContext;

  static BuildContext get context {
    if (_key?.currentContext == null) throw Exception('No context found');
    return _key!.currentContext!;
  }
}
