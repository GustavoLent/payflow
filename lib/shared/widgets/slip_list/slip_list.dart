import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';
import 'package:payflow/shared/widgets/slip_tile/slip_tile.dart';

class SlipList extends StatefulWidget {
  final SlipListController slipListController;
  final double maxHeight;
  final double maxWidth;

  const SlipList(
    this.maxHeight,
    this.maxWidth,
    this.slipListController,
  );

  @override
  _SlipListState createState() => _SlipListState();
}

class _SlipListState extends State<SlipList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxHeight,
      width: widget.maxWidth,
      child: ValueListenableBuilder<List<SlipModel>>(
        valueListenable: widget.slipListController.slipNotifier,
        builder: (_, slips, ___) {
          return ListView.builder(
            itemCount: slips.length,
            itemBuilder: (_, index) {
              SlipModel currSlip = slips[index];
              return SlipTile(currSlip);
            },
          );
        },
      ),
    );
  }
}
