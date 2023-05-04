import 'dart:ui';

import 'package:digital_data_tree/screens/form_detail_screen/form_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../app/app_const.dart';
import '../../../dummy_dart.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: .7,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => FormDetailScreen()),
                ),
              ),
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
                                popularList[i].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  '${popularList[i].desc.substring(0, 135)}...',
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
          },
          childCount: popularList.length,
        ),
      ),
    );
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
