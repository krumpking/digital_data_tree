import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/components/loader.dart';
import 'package:digital_data_tree/screens/home_screen/home_screen.dart';
import 'package:digital_data_tree/utils/dates.dart';
import 'package:digital_data_tree/utils/init.dart';
import 'package:digital_data_tree/view_models/form_info_view_model.dart';
import 'package:digital_data_tree/screens/welcome_screen/welcome_screen.dart';
import 'package:digital_data_tree/view_models/user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FormInfoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future _init = Init.initialize();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late int _counter;
  late Future<String> _d;
  late int diff = 0;

  @override
  void initState() {
    super.initState();

    _checkUser();
  }

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
      home: FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_counter == 1) {
              return const HomeScreen();
            } else {
              return const WelcomeScreen();
            }
          } else {
            return const Material(
              child: Center(
                child: Loader(),
              ),
            );
          }
        },
      ),
    );
  }

  _checkUser() async {
    _prefs.then((SharedPreferences prefs) {
      String? d = prefs.getString('date');
      if (d != null) {
        DateFormat format = DateFormat('yyyy-MM-dd');
        DateTime date = DateTime.now();

        String now = format.format(date);

        diff = DateAlgos.getDifferenceOfDates(now, d);
        if (diff.abs() > 30) {
          prefs.setInt('counter', 0);
        }
      }
    });

    var prefs = await _prefs;
    _counter = prefs.getInt('counter') ?? 0;
  }
}
