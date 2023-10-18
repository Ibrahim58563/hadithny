import 'package:flutter/material.dart';
import 'package:hadithny/features/random_hadith_feature/presentation/pages/random_hadith_page.dart';
import 'package:hadithny/features/random_hadith_feature/presentation/providers/random_hadith_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => RandomHadithProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Hadith',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RandomHadithPage(),
    );
  }
}
