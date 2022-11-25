import 'dart:io';
import 'imageData.dart';
import 'marker.dart';
import 'package:flutter/material.dart';

// A widget that edits a given image.
class EditImageScreen extends StatefulWidget {
  final ImageData image;
  final Marker marker;

  const EditImageScreen({super.key, required this.image, required this.marker});

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
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 20),
              Flexible(child: Card(child: Image.file(File(widget.image.getImagePath())))),
              const SizedBox(height: 20),
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

moveToTimeline(context,Marker marker){
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => marker.getPage()));
}
moveBack(context){
  Navigator.pop(context);
}