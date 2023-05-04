import 'package:digital_data_tree/app/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).padding.top > 0.0 ? 0.7 : 1.0;
    return Center(
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,

            /// Required, The loading type of the widget
            colors: const [AppColors.primaryColor],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: AppColors.white,

            /// Optional, Background of the widget
            pathBackgroundColor: AppColors.white));
  }
}
