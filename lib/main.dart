import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ejari/app_router.dart';
import 'package:ejari/state/locale_notifier.dart';
import 'package:ejari/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ejariLocaleNotifier.load();
  runApp(const EjariApp());
}

class EjariApp extends StatefulWidget {
  const EjariApp({super.key});

  @override
  State<EjariApp> createState() => _EjariAppState();
}

class _EjariAppState extends State<EjariApp> {
  late final GoRouter _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ejariLocaleNotifier,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Ejari',
          debugShowCheckedModeBanner: false,
          theme: buildEjariTheme(),
          routerConfig: _router,
          locale: ejariLocaleNotifier.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'Ejari',
          builder: (context, child) {
            final locale = Localizations.localeOf(context);
            return Directionality(
              textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
