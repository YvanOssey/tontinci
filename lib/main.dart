import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'core/router.dart';

void main() {
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
