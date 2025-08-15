import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:resta_dash/_core/storage/hive/hive_registrar.g.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:toastification/toastification.dart';

import 'main.export.dart';

void main() async {
  // Endpoints.testURL = 'http://192.168.1.133/qhub-360-server';

  ScaledWidgetsFlutterBinding.ensureInitialized(scaleFactor: (s) => s.width / 375);
  Animate.restartOnHotReload = true;
  await Hive.initFlutter();
  Hive.registerAdapters();
  await initDependencies();

  FlutterError.onError = (d) {
    if ('${d.summary}'.contains('package:flutter/src/rendering/mouse_tracker.dart')) return;
    FlutterError.presentError(d);
  };
  runApp(ProviderScope(child: TranslationProvider(child: const RestaDashApp())));
}

class RestaDashApp extends HookConsumerWidget {
  const RestaDashApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);

    return _INITApp(
      child: ToastificationWrapper(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: kAppName,
          theme: AppTheme.theme(false),
          darkTheme: AppTheme.theme(true),
          themeMode: ThemeMode.light,
          routerConfig: route,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [...GlobalMaterialLocalizations.delegates, LocaleNamesLocalizationsDelegate()],
        ),
      ),
    );
  }
}

class _INITApp extends HookConsumerWidget {
  const _INITApp({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! LISTENERS --------------------------
    ref.listen(loggedOutEvProvider, (_, n) {});

    ref.listen(
      appStateEventProvider,
      (_, v) => v.whenData((e) {
        final statusCtrl = ref.read(eventCtrlProvider.notifier);
        statusCtrl.update(e.status);
      }),
    );
    //! LISTENERS --------------------------

    return child;
  }
}
