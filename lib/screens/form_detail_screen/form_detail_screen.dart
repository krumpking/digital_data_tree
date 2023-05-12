import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/screens/form_capture_info_screen.dart';
import 'package:digital_data_tree/screens/form_data.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class FormDetailScreen extends StatefulWidget {
  const FormDetailScreen({super.key});

  @override
  State<FormDetailScreen> createState() => _FormDetailScreenState();
}

class _FormDetailScreenState extends State<FormDetailScreen> {
  List screensList = [
    const FormCaptureInfoScreen(),
    const FormDataScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: screensList[currentIndex],
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: DotNavigationBar(
            marginR: const EdgeInsets.symmetric(horizontal: 15),
            backgroundColor: AppColors.primaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            currentIndex: currentIndex,
            dotIndicatorColor: AppColors.fifthColor,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              DotNavigationBarItem(
                icon: const Icon(Icons.edit_note),
                selectedColor: Colors.white,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.storage),
                selectedColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
