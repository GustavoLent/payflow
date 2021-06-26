import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:payflow/shared/widgets/buttons_label/buttons_label.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  BarcodeScannerController controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(
          context,
          "/insert_slip",
          arguments: controller.status.barcode,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          showCameraPreview(),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              return SafeArea(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxHeight = constraints.maxHeight;
                      final maxWidth = constraints.maxWidth;

                      final buttonsHeight = maxHeight * 0.125;
                      final buttonsDividerStroke = maxWidth * 0.0025;
                      final buttonsWidth =
                          (maxWidth - buttonsDividerStroke) / 2;

                      return status.hasError
                          ? showErrorPage(
                              buttonsWidth,
                              buttonsHeight,
                              buttonsDividerStroke,
                              controller.scanWithCamera,
                              maxHeight,
                              () {},
                            )
                          : showScanPage(
                              buttonsWidth,
                              buttonsHeight,
                              buttonsDividerStroke,
                              maxHeight,
                              () {},
                            );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget showCameraPreview() {
    return ValueListenableBuilder<BarcodeScannerStatus>(
      valueListenable: controller.statusNotifier,
      builder: (_, status, __) {
        if (status.showCamera) {
          return controller.cameraController.buildPreview();
        } else {
          return Container();
        }
      },
    );
  }

  Widget showErrorPage(
    double buttonsWidth,
    double buttonsHeight,
    double dividerStroke,
    void Function() primaryButtonOnTap,
    double maxHeight,
    void Function() secondaryButtonOnTap,
  ) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBottomSheet(
            buttonsWidth: buttonsWidth,
            buttonsHeight: buttonsHeight,
            dividerStroke: dividerStroke,
            primaryButtonLabel: "Escanear novamente",
            primaryButtonOnTap: primaryButtonOnTap,
            primaryButtonTextStyle: TextStyles.buttonPrimary,
            maxHeight: maxHeight,
            secondaryButtonLabel: "Digitar código",
            secondaryButtonOnTap: secondaryButtonOnTap,
            subtitle:
                "Tente escanear novamente ou digite o código do seu boleto.",
            title: "Não foi possível identificar um código de barras.",
          ),
        ],
      ),
    );
  }

  Widget showScanPage(
    double buttonsWidth,
    double buttonsHeight,
    double dividerStroke,
    double maxHeight,
    void Function() secondaryButtonOnTap,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: AutoSizeText(
          "Escaneie o código de barras do boleto",
          style: TextStyles.buttonBackground,
        ),
        centerTitle: true,
        leading: BackButton(color: AppColors.background),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.black),
          ),
          Expanded(
            flex: 2,
            child: Container(color: Colors.transparent),
          ),
          Expanded(child: Container(color: Colors.black)),
          ButtonsLabel(
            buttonsWidth: buttonsWidth,
            dividerStroke: dividerStroke,
            primaryButtonLabel: "Inserir código do boleto",
            primaryButtonOnTap: () {
              Navigator.pushReplacementNamed(context, "/insert_slip");
            },
            buttonsHeight: buttonsHeight,
            secondaryButtonLabel: "Adicionar da galeria",
            secondaryButtonOnTap: secondaryButtonOnTap,
          ),
        ],
      ),
    );
  }
}
