import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/components/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../view_models/form_info_view_model.dart';

class FormLocationPicker extends StatefulWidget {
  const FormLocationPicker({Key? key, required this.label}) : super(key: key);
  final String label;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<FormLocationPicker> createState() => _FormLocationPicker();
}

class _FormLocationPicker extends State<FormLocationPicker> {
  var _centerLocation = LatLong(-17.824858, 31.053028);
  var _currLocation = LatLong(-17.824858, 31.053028);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: OpenStreetMapSearchAndPick(
        locationPinIconColor: AppColors.primaryColor,
        center: _centerLocation,
        buttonColor: AppColors.primaryColor,
        buttonText: 'Set Location',
        onPicked: (pickedData) {
          // print(pickedData.latLong.latitude);
          // print(pickedData.latLong.longitude);
          // print(pickedData.address);
          // Navigator.pop(context, pickedData);
          setState(() {
            _centerLocation = LatLong(
                pickedData.latLong.latitude, pickedData.latLong.longitude);
          });

          context.read<FormInfoViewModel>().addInfo({
            'label': widget.label,
            'info':
                'Lat${pickedData.latLong.latitude}Lng:${pickedData.latLong.longitude}',
            'element': 16
          });
          Navigator.pop(context);
        },
      ),
    ));
  }

  void _getCurrentLocation() async {
    var status = await Permission.location.status;
    // if (await Permission.location.serviceStatus.isEnabled) {

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _centerLocation = LatLong(position.latitude, position.longitude);
      });
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(Snack.snackError('Enable location permissions'));

      await Future.delayed(const Duration(seconds: 2));
      // openAppSettings();
      Map<Permission, PermissionStatus> status = await [
        Permission.location,
      ].request();
    }
    // } else {

    // permission is disabled
    // if (await Permission.location.isPermanentlyDenied) {}
    // }
  }
}
