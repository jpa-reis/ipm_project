import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'timeline.dart';

class PanelWidget extends StatelessWidget {

  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    super.key,
    required this.controller,
    required this.panelController
  });

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open()
  ;

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      controller: controller,
      children: <Widget>[
        const SizedBox(height: 10),
        buildHandle(),
        const ListTile(
          title: Center(
            child: Text(
              "Jardim Botânico de Lisboa",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.map),
            title: const Text("Jardim Botânico de Lisboa"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Timeline())
              );
            }
        ),
        const ListTile(
            leading: Icon(Icons.photo_album),
            title: Text("Jardim Zoológico")
        ),
        const ListTile(
            leading: Icon(Icons.phone),
            title: Text("Estufa Fria")
        )
      ],
    );
  }

}