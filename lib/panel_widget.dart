import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
  TextEditingController editingController = TextEditingController();


  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open()
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
      controller: widget.controller,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: editingController,
            decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
            ),
          )
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(gardens[index]['title']),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => gardens[index]['navigate']
                ));
              }
            );
          },
        ),
      ],
    );
  }

}
/**onTap: () {
Navigator.of(context).push(MaterialPageRoute(
builder: (context) => marker.getPage()
));**/