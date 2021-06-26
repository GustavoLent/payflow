import 'package:flutter/cupertino.dart';

class HomeController {
  int currentPage = 0;

  void setPage(int newPage) {
    currentPage = newPage;
  }

  void onClickAddButtom(BuildContext context) {
    Navigator.pushNamed(context, "/barcode_scanner");
  }
}
