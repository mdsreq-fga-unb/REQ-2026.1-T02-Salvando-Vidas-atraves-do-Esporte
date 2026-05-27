import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'consts.dart';
import 'routing/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: ANON_KEY);
  final supabase = Supabase.instance.client;

  runApp(
    MultiProvider(
      providers: [
        Provider<Logger>(create: (_) => Logger()),
        Provider<UserService>(create: (_) => UserService(supabase)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: "Salvando Vidas Através do Esporte",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457F0)),
        useMaterial3: true,
      ),
    );
  }
}
