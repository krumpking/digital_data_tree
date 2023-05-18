import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:digital_data_tree/components/scanner_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../view_models/form_info_view_model.dart';

class BarQRcodeScannerPageView extends StatefulWidget {
  const BarQRcodeScannerPageView({Key? key, required this.label})
      : super(key: key);
  final String label;

  @override
  BarQRcodeScannerPageViewState createState() =>
      BarQRcodeScannerPageViewState();
}

class BarQRcodeScannerPageViewState extends State<BarQRcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? capture;

  Widget cameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) {
                setState(() {
                  this.capture = capture;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
                            height: 50,
                            child: FittedBox(
                              child: Text(
                                capture?.barcodes.first.rawValue ??
                                    'Scan something!',
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton.normalButton(
                        title: 'Done',
                        onPress: () {
                          if (capture?.barcodes.first.rawValue != null) {
                            String? res = capture?.barcodes.first.rawValue;
                            var info = Provider.of<FormInfoViewModel>(context,
                                    listen: false)
                                .info;
                            context.read<FormInfoViewModel>().addInfo(
                                {'label': widget.label, 'info': res},
                                info.length);
                            Navigator.pop(context);
                          }
                        })
                  ]),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          cameraView(),
          Container(),
          cameraView(),
          cameraView(),
        ],
      ),
    );
  }
}
