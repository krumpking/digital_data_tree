import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/screens/form_capture_screen/form_capture_info_screen.dart';
import 'package:digital_data_tree/screens/form_data/form_data.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../view_models/form_info.dart';

class FormDetailScreen extends StatefulWidget {
  const FormDetailScreen({super.key});

  @override
  State<FormDetailScreen> createState() => _FormDetailScreenState();
}

class _FormDetailScreenState extends State<FormDetailScreen> {
  int currentIndex = 0;

  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;

  List bottomBarPages = [
    const FormCaptureInfoScreen(),
    const FormDataScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: true,
              notchColor: AppColors.fourthColor,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.edit_outlined,
                    color: AppColors.primaryColor,
                  ),
                  activeItem: Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                  itemLabel: 'Form',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.storage,
                    color: AppColors.primaryColor,
                  ),
                  activeItem: Icon(
                    Icons.storage,
                    color: Colors.white,
                  ),
                  itemLabel: 'Data',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );

                currentIndex = index;
                setState(() {});
              },
            )
          : null,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child:
            currentIndex == 0 ? const Icon(Icons.save) : const Icon(Icons.send),
        onPressed: () {
          // Do something

          if (currentIndex == 0) {
            dynamic info = Provider.of<FormInfo>(context, listen: false).info;
            print('INFO INFO $info');
          } else {}
        },
      ),
    );
  }
}
