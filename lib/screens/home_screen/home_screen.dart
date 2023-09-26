import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_data_tree/components/form_number_text.dart';
import 'package:digital_data_tree/screens/home_screen/components/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../app/app_const.dart';
import '../../components/form_long_text.dart';
import '../../components/loader.dart';
import '../../components/snack.dart';
import '../../models/form_model.dart';
import '../../repositories_abstracts/form_repository.dart';
import '../../repositories_abstracts/user_repository.dart';
import '../../view_models/search_view_model.dart';
import '../form_detail_screen/form_detail_screen.dart';
// import 'components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavBarSelectedIndex = 0;
  final __searchText = TextEditingController();
  List<FormModel> _forms = [];
  List<FormModel> _tempForms = [];
  final db = FirebaseFirestore.instance;
  final UserRepository _userRepository = GetIt.I.get();
  final FormRepository _formRepository = GetIt.I.get();
  var _loading = true;

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
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          _deleteForms();
          _getForms();
        },
        child: _loading
            ? const Loader()
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 45,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            _search(value.toLowerCase());
                          },
                          decoration: InputDecoration(
                            focusColor: AppColors.fifthColor,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.fifthColor),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: AppColors.fifthColor),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Search',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                'assets/svg/search.svg',
                                height: 20,
                                width: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                          childAspectRatio: .7,
                        ),
                        delegate: SliverChildBuilderDelegate((ctx, i) {
                          final form = _tempForms[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      FormDetailScreen(form: form)),
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
                                              backgroundColor:
                                                  AppColors.fourthColor,
                                              radius: 120,
                                            ),
                                          ),
                                          const Positioned(
                                            top: 130,
                                            left: -50,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppColors.thirdColor,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              form.title.length > 15
                                                  ? '${form.title.substring(0, 14)}..'
                                                  : form.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 10, 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
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
                      )),
                ],
              ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: GestureDetector(
          onLongPress: () {
            setState(() {
              _loading = true;
            });
            _deleteForms();
            _getForms();
          },
          child: const Text(
            'Digital Data Tree',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  void _deleteForms() async {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      await _formRepository.deleteAllForms();
    }
  }

  void _getForms() async {
    var currForms = await _formRepository.getForms();

    var user = await _userRepository.getUser();

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final myForms = await db
            .collection("forms")
            .where("editorNumbers", arrayContains: user[0].phoneNumber)
            .get();

        var d = myForms.docs;

        for (var docSnapshot in d) {
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

          var t = check(form, currForms as List<FormModel>);
          // Check that this form is not already added

          if (!t) {
            _formRepository.insertForm(form);
          }
        }

        var latestForms = await _formRepository.getForms();
        if (latestForms.isEmpty && currForms.isNotEmpty) {
          latestForms = currForms;
        }

        setState(() {
          _forms = latestForms as List<FormModel>;
          _tempForms = latestForms;
          _loading = false;
        });
      } else {
        setState(() {
          _forms = currForms as List<FormModel>;
          _tempForms = currForms;
          ;
          _loading = false;
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

  void _search(String s) {
    // Do something

    setState(() {
      _tempForms = [];
    });

    var search = s.toLowerCase();

    List<FormModel> searchRes = [];

    if (search.isNotEmpty) {
      for (FormModel form in _forms) {
        String descr = form.desc.toLowerCase();
        String title = form.title.toLowerCase();

        if (title == search ||
            descr == search ||
            descr.contains(search) ||
            title.contains(search)) {
          searchRes.add(form);
        }
      }
    }
    if (searchRes.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(Snack.snackError('No Forms matching $s found'));
    }
    setState(() {
      _tempForms = searchRes.isNotEmpty ? searchRes : _forms;
    });
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
