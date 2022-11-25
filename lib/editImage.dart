import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'main.dart';

// A widget that edits a given image.
class EditImageScreen extends StatefulWidget {
  final String imagePath;
  final String imageDate = "24/11/2022";
  final String imageDescription = "This is a rose";
  final Marker marker;
  final bool community = false;

  const EditImageScreen({super.key, required this.imagePath, required this.marker});

  @override
  State<StatefulWidget> createState() {
    return EditImageState();
  }
}

class EditImageState extends State<EditImageScreen> {
  late bool communitySwitch= widget.community;

  late TextEditingController descriptionController = TextEditingController(text: widget.imageDescription);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.imageDate),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 20),
              Flexible(child: Card(child: Image.file(File(widget.imagePath)))),
              const SizedBox(height: 20),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          saveImageInfo(descriptionController.text, communitySwitch);
          moveToTimeline(context,widget.marker);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.lightGreen,
          child: Text(
            widget.marker.getName(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          )),
    );
  }
}

saveImageInfo(String description,bool community){
  //TODO
}

moveToTimeline(context,Marker marker){
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => marker.getPage()));
}