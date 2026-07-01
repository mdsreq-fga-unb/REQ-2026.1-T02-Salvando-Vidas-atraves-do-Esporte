import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salvando_vidas/data/stores/theme/theme_store.dart';
import 'package:salvando_vidas/ui/global/themes/app_theme.dart';

import 'main_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (_) => const MyApp(),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeStoreProvider);
    final isDark = themeAsync.when(
      data: (v) => v,
      loading: () => false,
      error: (_, __) => false,
    );

    return MaterialApp.router(
      routerConfig: ref.read(routerProvider),
      title: "Salvando Vidas Através do Esporte",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),

      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
