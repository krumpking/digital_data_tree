import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/view_models/form_info.dart';
import 'package:digital_data_tree/screens/welcome_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => FormInfo(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Data Tree',
      theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(),
          primaryColor: AppColors.primaryColor,
          // primarySwatch: MaterialColor(AppColors.primaryColor, swatch),
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: AppColors.primaryColor),
      home: const WelcomeScreen(),
    );
  }
}
