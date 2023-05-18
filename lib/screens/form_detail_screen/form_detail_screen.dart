import 'package:aes256gcm/aes256gcm.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/models/info_model.dart';
import 'package:digital_data_tree/screens/form_capture_screen/form_capture_info_screen.dart';
import 'package:digital_data_tree/screens/form_data/form_data.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:intl/intl.dart';

import '../../models/form_model.dart';
import '../../repositories_abstracts/info_repository.dart';
import '../../repositories_abstracts/user_repository.dart';
import '../../utils/crypto.dart';
import '../../view_models/form_info_view_model.dart';
import '../../view_models/user_view_model.dart';

class FormDetailScreen extends StatefulWidget {
  const FormDetailScreen({super.key, required this.form});
  final FormModel form;
  @override
  State<FormDetailScreen> createState() => _FormDetailScreenState();
}

class _FormDetailScreenState extends State<FormDetailScreen> {
  int currentIndex = 0;

  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;
  final InfoRepository _formRepository = GetIt.I.get();

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
        children: List.generate(2, (index) => getScreen(index)),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child:
            currentIndex == 0 ? const Icon(Icons.save) : const Icon(Icons.send),
        onPressed: () async {
          // Do something

          if (currentIndex == 0) {
            var info =
                Provider.of<FormInfoViewModel>(context, listen: false).info;
            _addInfoToDataBase(info[info.length]);
          } else {}
        },
      ),
    );
  }

  Widget getScreen(int index) {
    List bottomBarPages = [
      FormCaptureInfoScreen(
        list: widget.form.elements,
      ),
      FormDataScreen(id: widget.form.id),
    ];
    return bottomBarPages[index];
  }

  void _addInfoToDataBase(List<Map<String, dynamic>> info) {
    List<Map<String, dynamic>> finalInfo = [];

    //Encrypt the information
    for (var element in info) {
      String encrypted = encrypt(element['info']);
      finalInfo.add({'label': element['label'], 'info': encrypted});
    }

    // Get current user
    var user = Provider.of<UserViewModel>(context, listen: false).user;

    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime date = DateTime.now();

    List<List<Map<String, dynamic>>> containerList = [];
    containerList.add(finalInfo);

    // Create info
    var infoModel = Info(
        encryption: 1,
        id: widget.form.id,
        dateCreated: format.format(date),
        info: containerList,
        editorNumber: user.phoneNumber,
        editorId: user.userId);

    // Add to provider
    context.read<FormInfoViewModel>().addInfoFinal(infoModel);

    // Add to database
    _formRepository.insertInfo(infoModel);
  }

  String encrypt(String info) {
    return Encryption.encrypt(
        info, widget.form.id + widget.form.id + widget.form.id);
  }
}
