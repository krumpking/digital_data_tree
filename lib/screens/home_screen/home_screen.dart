import 'package:digital_data_tree/components/form_number_text.dart';
import 'package:digital_data_tree/screens/home_screen/components/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_const.dart';
import '../../components/form_long_text.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavBarSelectedIndex = 0;
  final __searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SearchBar(),
          Forms(),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Digital Data Tree',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
