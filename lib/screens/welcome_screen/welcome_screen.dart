import 'package:digital_data_tree/components/snack.dart';
import 'package:digital_data_tree/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_const.dart';
import '../../components/app_buttons.dart';
import '../../components/loader.dart';
import '../../firebase_options.dart';
import '../../repositories_abstracts/user_repository.dart';
import '../../utils/crypto.dart';
import '../home_screen/home_screen.dart';
import 'components/clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final phoneNumber = TextEditingController();
  final otp = TextEditingController();
  var _verificationCode;
  bool _codeSent = false;
  bool loading = false;
  final UserRepository _userRepository = GetIt.I.get();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  List<Widget> picturesList = [
    Image.asset(
      'assets/pictures/3.png',
      key: UniqueKey(),
    ),
    Image.asset(
      'assets/pictures/2.png',
      key: UniqueKey(),
    ),
    Image.asset(
      'assets/pictures/1.png',
      key: UniqueKey(),
    ),
  ];

  List<Widget> textList = [
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'Say BYE to the days of hours spent trying to locate files, all information is available at your fingertips, secured with Bank-level encryption, and organized to your liking at a click of a button.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'With all your information, captured, secured and presented at a click of button, you can spend more time in more creative things that improve your business.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'Digitization can help to solve the information gap between departments by providing a way to share information quickly and easily. When departments have access to the same information, it can lead to improved efficiency, decision-making, customer service, and risk management.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    ),
  ];

  List<Widget> headinTextList = [
    const Text(
      'No more lost papers',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 15,
      ),
    ),
    const Text(
      'More time for fun',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 15,
      ),
    ),
    const Text(
      'Easy collaboration',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        body: loading
            ? Loader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          Positioned(
                            top: 25,
                            bottom: 0,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: picturesList[currentPage],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                      onPageChanged: (i) {
                        setState(() => currentPage = i);
                      },
                      itemCount: 3,
                      itemBuilder: (ctx, i) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            headinTextList[currentPage],
                            SizedBox(height: 10),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: textList[currentPage],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: AnimatedContainer(
                          height: 5,
                          width: currentPage == index ? 20 : 5,
                          duration: const Duration(milliseconds: 800),
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? AppColors.primaryColor
                                : AppColors.lightGray,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _codeSent
                          ? TextFormField(
                              controller: _codeSent ? otp : phoneNumber,
                              decoration: InputDecoration(
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
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Enter One Time Password',
                              ),
                              maxLines: 1,
                            )
                          : TextFormField(
                              controller: _codeSent ? otp : phoneNumber,
                              decoration: InputDecoration(
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
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Enter your phone number',
                              ),
                              maxLines: 1,
                            )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AppButton.normalButton(
                      title: _codeSent ? 'Login' : 'Get Started',
                      onPress: () async {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: ((context) => const HomeScreen()),
                        // ));

                        if (_codeSent) {
                          if (otp.text.isNotEmpty) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: _verificationCode,
                                          smsCode: otp.text))
                                  .then((value) async {
                                // if (value.user != null) {
                                //   setPassword(value.user!.uid);
                                // }

                                // Save user to database

                                DateFormat format = DateFormat('yyyy-MM-dd');
                                DateTime date = DateTime.now();

                                // Add counter into shared preferences
                                _prefs.then((SharedPreferences prefs) {
                                  prefs.setInt('counter', 1);
                                  prefs.setString('date', format.format(date));
                                });

                                // ignore: unnecessary_new
                                final newUser = new UserModel(
                                  id: 0,
                                  userId: value.user!.uid,
                                  phoneNumber: phoneNumber.text,
                                  // dateCreated: format.format(date)
                                );

                                _userRepository.insertUser(newUser);

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const HomeScreen()),
                                ));
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snack.snack('Invalid OTP'));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(Snack.snack(
                                'Please ensure you enter your verification code'));
                          }
                        } else {
                          if (phoneNumber.text.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: phoneNumber.text,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      Snack.snack('Verification Completed'));
                                  print(credential);

                                  // await FirebaseAuth.instance
                                  //     .signInWithCredential(credential)
                                  //     .then((value) async {
                                  //   if (value.user != null) {
                                  //     // setPassword(value.user!.uid);
                                  //   }
                                  // });
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                verificationFailed: (FirebaseAuthException e) {
                                  print(e.message);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      Snack.snack(e.message.toString()));
                                  print(e);
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                codeSent:
                                    (String verficationID, int? resendToken) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      Snack.snack('Verification Sent'));
                                  setState(() {
                                    _verificationCode = verficationID;
                                    _codeSent = true;
                                  });
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationID) {
                                  setState(() {
                                    _verificationCode = verificationID;
                                  });
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(Snack.snack('Time Out'));
                                },
                                timeout: Duration(seconds: 120));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                Snack.snack(
                                    'Make sure you added your phone number'));
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
      ),
    );
  }
}
