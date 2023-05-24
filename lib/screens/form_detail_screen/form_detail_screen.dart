import 'package:aes256gcm/aes256gcm.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/models/info_model.dart';
import 'package:digital_data_tree/screens/form_capture_screen/form_capture_info_screen.dart';
import 'package:digital_data_tree/screens/form_data/form_data.dart';
import 'package:digital_data_tree/utils/random.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:intl/intl.dart';

import '../../components/loader.dart';
import '../../components/snack.dart';
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
  final InfoRepository _infoRepository = GetIt.I.get();
  final UserRepository _userRepository = GetIt.I.get();
  bool _loading = false;
  final db = FirebaseFirestore.instance;

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
      body: _loading
          ? const Loader()
          : PageView(
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
          var info =
              Provider.of<FormInfoViewModel>(context, listen: false).info;
          if (currentIndex == 0) {
            // // Needs attention
            _addInfoToLocalDataBase(info, context);
          } else {
            _addInfoToCloudDataBase(context);
          }
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

  void _addInfoToLocalDataBase(
      List<Map<String, dynamic>> info, BuildContext context) async {
    List<Map<String, dynamic>> finalInfo = [];

    setState(() {
      _loading = false;
    });

    //Encrypt the information
    for (var element in info) {
      String encrypted = "";
      if (element['info'] != null) {
        encrypted = encrypt(element['info']);
      }
      finalInfo.add({'label': element['label'], 'info': encrypted});
    }

    // Get current user
    var user = await _userRepository.getUser();

    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime date = DateTime.now();

    List<Map<String, dynamic>> containerList = [];
    containerList.add({"data": finalInfo, "editorNumber": user[0].phoneNumber});

    // Create info
    var infoModel = Info(
        title: widget.form.title,
        descr: widget.form.desc,
        encryption: 1,
        infoId: widget.form.id,
        dateCreated: format.format(date),
        info: containerList,
        editorId: user[0].userId);

    // // Add to provider  Version 2 Work
    // if (context.mounted) {
    //   context.read<FormInfoViewModel>().addInfoFinal(infoModel);
    // }

    // _infoRepository.deleteInfo(infoModel);

    if (finalInfo.isNotEmpty) {
      // // Add to database
      _infoRepository.insertInfo(infoModel).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snack.snack('Information captured'));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          Snack.snack('Please ensure you have captured some information'));
    }

    setState(() {
      _loading = false;
    });
  }

  void _addInfoToCloudDataBase(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    List<dynamic> _info = await _infoRepository.getInfo(widget.form.id);

    Map<String, dynamic> data = {
      'title': _info[0].title,
      'descr': _info[0].descr,
      'infoId': _info[0].infoId,
      'encryption': _info[0].encryption,
      'dateCreated': _info[0].dateCreated,
      'info': _info[0].info,
      'editorId': _info[0].editorId,
    };

    final dataFromDB = await db
        .collection("data")
        .where("infoId", isEqualTo: _info[0].infoId)
        .get();

    if (dataFromDB.docs.isNotEmpty) {
      String id = "";
      for (var docSnapshot in dataFromDB.docs) {
        id = docSnapshot.id;
      }
      db.collection("data").doc(id).update(data).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(Snack.snack('Data UPDATED'));

        setState(() {
          _loading = false;
        });
      }, onError: (e) {
        print("Error updating document $e");
        print("Error updating document $e");
        ScaffoldMessenger.of(context).showSnackBar(
            Snack.snackError('There was an error updating the information'));

        setState(() {
          _loading = false;
        });
      });
    } else {
      db.collection("data").add(data).then((documentSnapshot) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snack.snack('Data uploaded to the Cloud!!'));

        setState(() {
          _loading = false;
        });
      }, onError: (e) {
        print("Error updating document $e");
        ScaffoldMessenger.of(context).showSnackBar(
            Snack.snackError('There was an error updloading the information'));

        setState(() {
          _loading = false;
        });
      });
    }
  }

  String encrypt(String info) {
    return Encryption.encrypt(
        info, widget.form.id + widget.form.id + widget.form.id);
  }
}
