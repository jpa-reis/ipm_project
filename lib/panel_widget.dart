import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'gardens.dart';
import 'globals.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
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
              (currentGarden == 1) ? "Jardim Botânico de Lisboa" : "Estufa Fria",
              style: TextStyle(fontSize: 18, color: Color(0xFFD3D3D3)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
                hintText: "Search",
              hintStyle: TextStyle(color: Color(0xFFD3D3D3)),
                prefixIcon: Icon(Icons.search, color: Color(0xFFD3D3D3),),
            ),
            onChanged: searchGarden,
          )
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: gardenOptions.length,
          itemBuilder: (context, index) {
            final garden = gardenOptions[index];
            return ListTile(
              title: Text(garden.name, style: TextStyle(color: Color(0xFFD3D3D3)),),
              onTap: () => setState(() {
                currentGarden = garden.id;
                widget.panelController.close();
              })
            );
          },
        ),
      ],
    );
  }

}
