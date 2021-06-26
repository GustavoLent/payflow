import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_slip/insert_slip_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.orange,
      ),
      title: 'Pay Flow',
      initialRoute: "/splash",
      routes: {
        "/barcode_scanner": (context) => BarcodeScannerPage(),
        "/home": (context) => HomePage(
              ModalRoute.of(context).settings.arguments as UserModel,
            ),
        "/insert_slip": (context) => InsertSlipPage(
              barcodeValue:
                  ModalRoute.of(context).settings.arguments as String ?? null,
            ),
        "/login": (context) => LoginPage(),
        "/splash": (context) => SplashPage(),
      },
    );
  }
}
