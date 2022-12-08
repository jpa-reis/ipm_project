import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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


  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: <Widget>[
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xFFE0E0E0),
            ),
          ),
        ),
        ListTile(
          title: Center(
            child: Text(
              widget.marker.name,
              style: TextStyle(fontSize: 21, color: Color(0xFFD3D3D3)),
            ),
          ),
        ),
        SizedBox(height: 2,),
        Divider(
          thickness: 1.0,
          indent: 30.0,
          endIndent: 30.0,
          color: Color(0xFFD3D3D3),
        ),
        const SizedBox(height: 10),
        ListTile(
          title: widget.marker.description == "" ? Row(
            children: [
              Text("This marker has no description yet!",
                style: TextStyle(color: Color(0xFFD3D3D3)),),
              Center(
                child: IconButton(
                  icon: Icon( Icons.edit, color: Color(0xFFD3D3D3),),
                  onPressed: () { setState(() {
                  widget.marker.description = "Sample description";
                });},),
              ),
            ],
          ) : Text(
              widget.marker.description,
              style: TextStyle(color: Color(0xFFD3D3D3)),),
        )
      ],
    );
  }

}
