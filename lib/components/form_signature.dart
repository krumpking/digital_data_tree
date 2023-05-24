import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormSignature extends StatelessWidget {
  FormSignature({Key? key, required this.label}) : super(key: key);
  final String label;

  final HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).padding.top > 0.0 ? 0.7 : 1.0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: size.height,
                  width: size.width / 1.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  child: HandSignature(
                    control: control,
                    color: Colors.black,
                    width: 1.0,
                    maxWidth: 10.0,
                    type: SignatureDrawType.shape,
                  ),
                )),
            Center(
              child: SizedBox(
                  height: size.height,
                  width: size.width / 5,
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: -math.pi / 2,
                        child: AppButton.normalButton(
                            title: "Save",
                            onPress: () async {
                              var res = await control.toImage(
                                color: Colors.blueAccent,
                                background: Colors.white,
                                fit: false,
                              );

                              context.read<FormInfoViewModel>().addInfo(
                                  {'label': label, 'info': res.toString()});
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                        height: size.height / 3,
                        width: size.width / 5,
                      ),
                      Transform.rotate(
                        angle: -math.pi / 2,
                        child: AppButton.normalButton(
                            title: "Clear",
                            onPress: () async {
                              control.clear();
                            }),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
