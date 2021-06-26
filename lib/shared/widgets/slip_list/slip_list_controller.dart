import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlipListController {
  final slipNotifier = ValueNotifier(<SlipModel>[]);

  List<SlipModel> get slips => slipNotifier.value;

  set slips(List<SlipModel> slips) => slipNotifier.value = slips;

  Future<void> getSlips() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("slips") ?? <String>[];

      slips = response.map((slip) => SlipModel.fromJson(slip)).toList();
    } catch (error) {
      slips = <SlipModel>[];
    }
  }
}
