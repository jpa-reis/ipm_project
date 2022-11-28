import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:ipm_project/main.dart';

import 'imageData.dart';
import 'marker.dart';
import 'package:flutter/material.dart';
import 'timeline.dart';
import 'globals.dart';
// A widget that edits a given image.
class EditImageScreen extends StatefulWidget {

  final ImageData image;
  final Marker marker;
  final int currentGarden;

  const EditImageScreen({super.key, required this.image, required this.marker, required this.currentGarden});

  @override
  State<StatefulWidget> createState() {
    return EditImageState();
  }
}

class EditImageState extends State<EditImageScreen> {
  late bool communitySwitch= widget.image.getCommunity();

  late TextEditingController descriptionController = TextEditingController(text: widget.image.getDescription());

  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      backgroundColor: Colors.grey,
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery. of(context). size. height*0.5,
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.image.date),
                    const SizedBox(width: 60),
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
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          widget.image.setDescription(descriptionController.text);
          widget.image.setCommunity(communitySwitch);
          moveToTimeline(context,widget.marker);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            boxShadow: const [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          height: bottomBarHeight,
          child: Align(
              alignment: Alignment.center,
              child: Text(widget.marker.name,style: TextStyle(fontSize: 25, color: Colors.black))
          ),
        )
    );
  }
}


moveToTimeline(context,Marker marker){
  if(currentGarden == 1){
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Timeline(indexOf: markers1.indexOf(marker), currentGarden: currentGarden, marker: marker,)));
  }
  else{
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Timeline(indexOf: markers2.indexOf(marker), currentGarden: currentGarden, marker: marker,)));
  }

}
moveBack(context){
  Navigator.pop(context);
}