import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'gardens.dart';
import 'globals.dart';
import 'marker.dart';

class PanelWidgetTimeline extends StatefulWidget {
  final Marker marker;
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidgetTimeline({
    Key? key,
    required this.marker,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidgetTimeline> createState() => _PanelWidgetTimelineState();
}

class _PanelWidgetTimelineState extends State<PanelWidgetTimeline> {
  final textController = TextEditingController();
  List<Garden> gardenOptions = gardens;

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();


  Widget buildHandle() {
    return GestureDetector(
      onTap: togglePanel,
      child: Center(
        child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFE0E0E0),
          ),
        ),
      )
    );
  }

  void searchGarden(String query) {
    final suggestions = gardens.where((garden) {
      final gardenName = garden.name.toLowerCase();
      final searchQuery = query.toLowerCase();

      return gardenName.contains(searchQuery);
    }).toList();

    setState(() => gardenOptions = suggestions);
  }


  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: <Widget>[
        const SizedBox(height: 10),
        buildHandle(),
        ListTile(
          title: Center(
            child: Text(
              widget.marker.name,
              style: TextStyle(fontSize: 19),
            ),
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: 30.0,
          endIndent: 30.0,
        ),
        const SizedBox(height: 10),
        ListTile(
          title: Text(
              widget.marker.description),
        )
      ],
    );
  }

}
