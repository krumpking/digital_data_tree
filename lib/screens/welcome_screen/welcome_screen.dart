import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_const.dart';
import '../../components/app_buttons.dart';
import '../../components/loader.dart';
import '../../firebase_options.dart';
import '../../utils/crypto.dart';
import '../home_screen/home_screen.dart';
import 'components/clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  initState() {
    super.initState();

    // Add listeners to this class
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
                          children: const [
                            Text(
                              'Find your best outfit\nand look great',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, standard dummy text ever since the 1500s.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
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
                        var encrypted = Encryption.encrypt(
                            'Jumping jumping jumping',
                            'my 32 length key................');
                        print('ENCRYPTED $encrypted');
                        var dencrypted = Encryption.decrypt(
                            encrypted, 'my 32 length key................');
                        print('DECRYPTED $dencrypted');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const HomeScreen()),
                        ));

                        // if (_codeSent) {
                        //   try {
                        //     await FirebaseAuth.instance
                        //         .signInWithCredential(
                        //             PhoneAuthProvider.credential(
                        //                 verificationId: _verificationCode,
                        //                 smsCode: otp.text))
                        //         .then((value) async {
                        //       // if (value.user != null) {
                        //       //   setPassword(value.user!.uid);
                        //       // }
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: ((context) => const HomeScreen()),
                        //       ));

                        //       print('WE ARE IN');
                        //     });
                        //   } catch (e) {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text('Invalid OTP!'),
                        //     ));
                        //   }
                        // } else {
                        //   setState(() {
                        //     loading = true;
                        //   });

                        //   await FirebaseAuth.instance.verifyPhoneNumber(
                        //       phoneNumber: phoneNumber.text,
                        //       verificationCompleted:
                        //           (PhoneAuthCredential credential) async {
                        //         print('VERIFICATION COMPLETED');
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text('VERIFICATION COMPLETED'),
                        //         ));
                        //         print(credential);

                        //         // await FirebaseAuth.instance
                        //         //     .signInWithCredential(credential)
                        //         //     .then((value) async {
                        //         //   if (value.user != null) {
                        //         //     // setPassword(value.user!.uid);
                        //         //   }
                        //         // });
                        //         setState(() {
                        //           loading = false;
                        //         });
                        //       },
                        //       verificationFailed: (FirebaseAuthException e) {
                        //         print(e.message);
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text(e.message.toString()),
                        //         ));
                        //         setState(() {
                        //           loading = false;
                        //         });
                        //       },
                        //       codeSent:
                        //           (String verficationID, int? resendToken) {
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text("VERIFICATION SENT"),
                        //         ));
                        //         setState(() {
                        //           _verificationCode = verficationID;
                        //           _codeSent = true;
                        //         });
                        //         setState(() {
                        //           loading = false;
                        //         });
                        //       },
                        //       codeAutoRetrievalTimeout:
                        //           (String verificationID) {
                        //         setState(() {
                        //           _verificationCode = verificationID;
                        //         });
                        //         setState(() {
                        //           loading = false;
                        //         });
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text("TIME OUT"),
                        //         ));
                        //       },
                        //       timeout: Duration(seconds: 120));
                        // }
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
