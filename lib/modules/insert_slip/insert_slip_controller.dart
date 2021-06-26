import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertSlipController {
  final formKey = GlobalKey<FormState>();
  SlipModel slipModel = SlipModel();

  String validateName(String value) {
    return value.isEmpty ? "O nome não pode ser vazio" : null;
  }

  String validateDueDate(String value) {
    return value.isEmpty ? "A data de vencimento não pode ser vazia" : null;
  }

  String validateValue(double value) {
    return value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  }

  String validateCode(String value) {
    return value.isEmpty ? "O código do boleto não pode ser vazio" : null;
  }

  Future<void> storeSlip() async {
    final instance = await SharedPreferences.getInstance();
    List<String> slips = instance.getStringList("slips") ?? <String>[];

    String slipAsJson = slipModel.toJson();
    slips.add(slipAsJson);

    await instance.setStringList("slips", slips);
    return;
  }

  Future<void> registerSlip() async {
    final formState = formKey.currentState;
    final isValid = formState.validate();

    if (isValid) {
      return await this.storeSlip();
    }
  }

  void onChange({String name, String dueDate, double value, String barcode}) {
    slipModel = slipModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }
}
