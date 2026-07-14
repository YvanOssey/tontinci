import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme.dart';
import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cvrzfmkucedfykzyrpmu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2cnpmbWt1Y2VkZnlrenlycG11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQwNTY1NTcsImV4cCI6MjA5OTYzMjU1N30.x_KqjtCJOYD0fdsaGOIX3bfZJRlOOIM19V9smWqNjDI',
  );

  runApp(const TontinCIApp());
}

class TontinCIApp extends StatelessWidget {
  const TontinCIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TontinCI',
      debugShowCheckedModeBanner: false,
      theme: TTheme.dark,
      routerConfig: router,
    );
  }
}
