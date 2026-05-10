import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/notifiers.dart';
import 'package:lloydportfolio/features/onboarding/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: themeIndex,
      builder: (context, _, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lloyd Portfolio',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
