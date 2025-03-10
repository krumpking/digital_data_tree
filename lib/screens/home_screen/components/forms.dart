import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_data_tree/models/form_model.dart';
import 'package:digital_data_tree/screens/form_detail_screen/form_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../app/app_const.dart';
import '../../../components/snack.dart';
import '../../../repositories_abstracts/form_repository.dart';
import '../../../repositories_abstracts/user_repository.dart';
import '../../../view_models/search_view_model.dart';
import '../../../view_models/user_view_model.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  List<FormModel> _forms = [];
  List<FormModel> _tempForms = [];
  final db = FirebaseFirestore.instance;
  final UserRepository _userRepository = GetIt.I.get();
  final FormRepository _formRepository = GetIt.I.get();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getForms();
  }

  @override
  Widget build(BuildContext context) {
    // Add User to provider

    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: .7,
          ),
          delegate: SliverChildBuilderDelegate((ctx, i) {
            final form = _forms[i];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => FormDetailScreen(form: form)),
                  ),
                );
              },
              child: Card(
                elevation: .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClipPath(
                        clipper: MyClipper(),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              color: AppColors.primaryColor,
                            ),
                            const Positioned(
                              top: 50,
                              right: -100,
                              child: CircleAvatar(
                                backgroundColor: AppColors.fourthColor,
                                radius: 120,
                              ),
                            ),
                            const Positioned(
                              top: 130,
                              left: -50,
                              child: CircleAvatar(
                                backgroundColor: AppColors.thirdColor,
                                radius: 80,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.1,
                                child: Image.asset(
                                  'assets/pictures/background_vector.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                form.title.length > 15
                                    ? '${form.title.substring(0, 14)}..'
                                    : form.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  form.desc.length > 135
                                      ? '${form.desc.substring(0, 135)}...'
                                      : '${form.desc}...',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }, childCount: _tempForms.length),
        ));
  }

  Future<void> _getForms() async {
    var currForms = await _formRepository.getForms();

    var user = await _userRepository.getUser();

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final myForms = await db
            .collection("forms")
            .where("editorNumbers", arrayContains: user[0].phoneNumber)
            .get();

        for (var docSnapshot in myForms.docs) {
          var el = docSnapshot.data();
          var form = FormModel(
              id: docSnapshot['id'],
              creatorId: el['creatorId'],
              adminId: el['adminId'],
              date: el['dateCreated'],
              desc: el['description'],
              editNumbers: el['editorNumbers'],
              elements: el['elements'],
              title: el['title']);

          // Check that this form is not already added
          if (!check(form, currForms as List<FormModel>)) {
            _formRepository.insertForm(form);
          }
        }

        var latestForms = await _formRepository.getForms();
        setState(() {
          _forms = latestForms as List<FormModel>;
          _tempForms = latestForms;
        });
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          Snack.snack('You are currently not connected to the internet!'));
      setState(() {
        _forms = currForms as List<FormModel>;
        _tempForms = currForms;
      });
    }
  }

  List<FormModel> _search(BuildContext context) {
    // Do something
    var search =
        Provider.of<SearchViewModel>(context, listen: false).searchString;

    setState(() {
      _tempForms = [];
    });

    List<FormModel> searchRes = [];

    for (FormModel form in _forms) {
      if (form.title == search || form.desc == search) {
        searchRes.add(form);
      } else {
        bool isMatch = false;
        for (int i = 0; i < form.title.length; i++) {
          if (form.title[i] == search[0]) {
            isMatch = true;
            for (int j = 1; j < search.length; j++) {
              if (form.title[i + j] != search[j]) {
                isMatch = false;
                break;
              }
            }
            if (isMatch) {
              searchRes.add(form);
              break;
            }
          }
        }
      }
      if (searchRes.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snack.snackError('No Forms matching $search found'));
      }
      setState(() {
        _tempForms = searchRes.isNotEmpty ? searchRes : _forms;
      });
    }
    return searchRes.isNotEmpty ? searchRes : _forms;
  }

  bool check(FormModel form, List<FormModel> currForms) {
    bool res = false;

    for (var i = 0; i < currForms.length; i++) {
      var map = currForms[i];
      if (map.id == form.id) {
        // If the variable is present in the map, set the variableExists variable to true.
        res = true;
        break;
      }
    }

    return res;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);

    path.lineTo(size.width - 20, size.height - 20);
    path.quadraticBezierTo(
        size.width, size.height - 25, size.width, size.height - 50);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
