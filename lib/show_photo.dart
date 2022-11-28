import 'dart:developer';
import 'dart:io';
import 'dart:ui';
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
                        child: Text(/*widget.image.description*/ "aaaa"),
                  ),),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, right: 20),
                    child: Row(
                      children: [
                        Visibility(
                          visible: (widget.i >= 1),
                          child: IconButton(
                              onPressed: () {
                                if(currentGarden == 1){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShowPhoto(image: images1[widget.indexOf][widget.i-1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i-1, currentGarden: currentGarden,)
                                  ));
                                }else{
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
                          padding: const EdgeInsets.only(top:20, left: 20),
                          child: Text(widget.image.date, style: TextStyle(fontSize: 20),),
                        ),
                        Spacer(),
                        Visibility(
                          visible: checkVisible(),
                          child: IconButton( onPressed: () {
                            if(currentGarden == 1){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPhoto(image: images1[widget.indexOf][widget.i+1], marker: markers1[widget.indexOf], indexOf: widget.indexOf, i: widget.i+1, currentGarden: currentGarden,)
                              ));
                            }else{
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

/*import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ipm_project/panel_widget.dart';
import 'globals.dart' as globals;*/

/*class ShowPhoto extends StatefulWidget {
  const ShowPhoto({super.key});

  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  final panelController = PanelController();

  static final mode = globals.mode;

  Widget getTimelinePhoto(BuildContext context) {
    final buttonHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 46, 163, 81), // not final
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            const Text("22/06/2022"),
            Positioned(
              left: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto anterior */}),
            ),
            Positioned(
              right: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto seguinte */}),
            ),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: const [
                [Colors.black],
                [Colors.black]
              ],
              activeFgColor: Color.fromARGB(255, 255, 255, 255),
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['', ''],
              radiusStyle: true,
              onToggle: (index) {
                // Logic of public/private
                switch (index) {
                  case 0:
                    globals.mode = globals.PhotoModes.private;
                    break;
                  default:
                    globals.mode = globals.PhotoModes.public;
                }
              },
            ), // Toggle entre ser publico ou privado
            const Image(
              alignment: Alignment.center,
              image: NetworkImage(
                  'https://www.thecolvinco.com/pt/c/wp-content/uploads/sites/4/2020/07/ROSE-RED-RED-NAOMI-50-768x768.jpg'), // Foto
            ),
            const Text("Isto é uma linda rosa")
          ],
        ));
  }

  Widget getCommunityPhoto(BuildContext context) {
    final buttonHeight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 173, 137, 17), // not final
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: const [
                [Colors.black],
                [Colors.black]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['', ''],
              radiusStyle: true,
              onToggle: (index) {
                // Logic of public/private
                switch (index) {
                  case 0:
                    globals.mode = globals.PhotoModes.private;
                    break;
                  default:
                    globals.mode = globals.PhotoModes.public;
                }
              },
            ),
            Positioned(
              left: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto anterior */}),
            ),
            Positioned(
              right: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto seguinte */}),
            ), // Toggle entre ser publico ou privado
            const Image(
              image: NetworkImage(
                  'https://www.thecolvinco.com/pt/c/wp-content/uploads/sites/4/2020/07/ROSE-RED-RED-NAOMI-50-768x768.jpg'), // Foto
            ),
            const Text("Isto é uma linda rosa"), // Descrição da foto
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case globals.PhotoModes.private:
        return getTimelinePhoto(context);
      case globals.PhotoModes.public:
        return getCommunityPhoto(context);
    }
  }
}*/
