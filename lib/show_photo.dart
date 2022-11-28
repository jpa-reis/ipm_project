import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:ipm_project/editImage.dart';
import 'package:ipm_project/panel_widget.dart';
import 'package:ipm_project/panel_widget_timeline.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'imageData.dart';
import 'marker.dart';
import 'package:flutter/material.dart';
import 'timeline.dart';
import 'globals.dart';


// A widget that edits a given image.
class ShowPhoto extends StatefulWidget {
  final ImageData image;
  final Marker marker;
  final int i;
  final int indexOf;
  final int currentGarden;

  const ShowPhoto({super.key, required this.image, required this.marker,
    required this.indexOf, required this.i, required this.currentGarden});

  @override
  State<StatefulWidget> createState() {
    return ShowPhotoState();
  }
}

class ShowPhotoState extends State<ShowPhoto> {
  late bool communitySwitch = widget.image.getCommunity();

  late TextEditingController descriptionController =
      TextEditingController(text: widget.image.getDescription());


  bool checkVisible() {
    if (currentGarden == 1) {
      return (widget.i < (images1[widget.indexOf].length-1));
    }
    else {
      return (widget.i < (images1[widget.indexOf].length-1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    final panelController = PanelController();
    const double buttonSize = 50.0;
    const double initButtonPosition = buttonSize + 30.0;
    late double buttonPosition;
    buttonPosition = initButtonPosition;
    double padding = 15.0;
    buttonPosition = panelHeightClosed + padding;
    late bool panelClosed = true;
    late bool openMapSearch = false;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // The image is stored as a file on the device. Use the `Image.file`
          // constructor with the given path to display the image.
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Community:"),
                          Switch(
                            value: communitySwitch,
                            onChanged: (value) {
                              setState((){communitySwitch = value;});
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ]
                    ),*/
                  Container(
                    height: MediaQuery. of(context). size. height*0.6,
                    width:  MediaQuery. of(context). size. width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.file(File(widget.image.getImagePath())).image,
                        fit: BoxFit.cover,
                      ),

                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 20.0),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                          child: Image.file(File(widget.image.getImagePath())) /* add child content here */,
                  ),),),
                  /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.image.date),
                    ),*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.image.description),
                  ),),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, right: 20),
                    child: Row(
                      children: [
                        Visibility(
                          visible: (widget.i >= 1),
                          child: IconButton(
                              onPressed: () {
                                if(currentGarden == 1){
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShowPhoto(image: images1[widget.indexOf][widget.i-1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i-1, currentGarden: currentGarden,)
                                  ));
                                }else{
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShowPhoto(image: images2[widget.indexOf][widget.i-1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i-1, currentGarden: currentGarden,)
                                  ));
                                }
                              },//images[widget.indexOf][widget.i-1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i-1
                              icon: Icon(Icons.arrow_circle_left, size: 50,)),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top:20, left: 70),
                          child: Text(DateFormat('MM-dd').format(widget.image.date), style: TextStyle(fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20, left: 20),
                          child: IconButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditImageScreen(image: widget.image, marker: widget.marker, currentGarden: widget.currentGarden)
                            ));
                          }, icon: Icon(Icons.edit)),
                        ),
                        Spacer(),
                        Visibility(
                          visible: checkVisible(),
                          child: IconButton( onPressed: () {
                            if(currentGarden == 1){
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPhoto(image: images1[widget.indexOf][widget.i+1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i+1, currentGarden: currentGarden,)
                              ));
                            }else{
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPhoto(image: images2[widget.indexOf][widget.i+1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i+1, currentGarden: currentGarden,)
                              ));
                            }
                          }, icon: Icon(Icons.arrow_circle_right, size: 50,)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              SlidingUpPanel(
                controller: panelController,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                maxHeight: panelHeightOpen,
                minHeight: panelHeightClosed,
                panelBuilder: (controller) => PanelWidgetTimeline(
                  marker: widget.marker,
                  controller: controller,
                  panelController: panelController,
                ),
                onPanelSlide: (position) => setState(() {
                  buttonPosition =
                      position * (panelHeightOpen - panelHeightClosed) +
                          initButtonPosition;
                  panelClosed = ((buttonPosition - initButtonPosition) == 0);
                  openMapSearch = false;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


moveToTimeline(context, Marker marker) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Timeline(indexOf: markers1.indexOf(marker),
        currentGarden: currentGarden, marker: marker,)));
}

moveBack(context) {
  Navigator.pop(context);
}
