import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/my_slips/my_slips_page.dart';
import 'package:payflow/modules/slips_statement/slips_statement_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MySlipsPage(key: UniqueKey()),
      SlipsStatementPage(key: UniqueKey()),
    ];
    int currentPageIndex = homeController.currentPage;
    Widget currentPage = pages[currentPageIndex];

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;

          final appBarHeight = maxHeight * 0.15;
          final bottomNavBarHeight = maxHeight * 0.11;

          return Scaffold(
            appBar: appBar(appBarHeight),
            body: currentPage,
            bottomNavigationBar: bottomNavBar(
              homeController,
              bottomNavBarHeight,
            ),
          );
        },
      ),
    );
  }

  PreferredSize appBar(double maxHeight) {
    final profileName = widget.user.name;
    final profilePhotoSize = maxHeight * 0.49;
    final profilePhotoUrl = widget.user.photoURL;

    return PreferredSize(
      preferredSize: Size.fromHeight(maxHeight),
      child: Container(
        height: maxHeight,
        color: AppColors.primary,
        child: Center(
          child: ListTile(
            title: Text.rich(
              TextSpan(
                text: "Olá, ",
                style: TextStyles.titleRegular,
                children: [
                  TextSpan(
                    text: "$profileName",
                    style: TextStyles.titleBoldBackground,
                  ),
                ],
              ),
            ),
            subtitle: AutoSizeText(
              "Mantenha suas contas em dia!",
              style: TextStyles.captionShape,
            ),
            trailing: Container(
              height: profilePhotoSize,
              width: profilePhotoSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(profilePhotoUrl),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar(HomeController homeController, double maxHeight) {
    final iconSize = maxHeight * 0.4;

    final mainIconSize = maxHeight * 0.85;
    final mainIconRadius = mainIconSize * 0.1;

    final iconBottomPadding = (maxHeight - iconSize) * 0.2;
    final mainIconBottomPadding = maxHeight - mainIconSize;

    return Container(
      height: maxHeight,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: iconBottomPadding),
            child: IconButton(
              icon: Icon(
                Icons.home,
                color: homeController.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
                size: iconSize,
              ),
              onPressed: () {
                homeController.setPage(0);
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: mainIconBottomPadding),
            child: GestureDetector(
              onTap: () => homeController.onClickAddButtom(context),
              child: Container(
                height: mainIconSize,
                width: mainIconSize,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(mainIconRadius),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                  size: iconSize,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: iconBottomPadding),
            child: IconButton(
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
                size: iconSize,
              ),
              onPressed: () {
                homeController.setPage(1);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
