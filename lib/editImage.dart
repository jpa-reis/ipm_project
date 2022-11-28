import 'dart:developer';
import 'dart:io';
import 'imageData.dart';
import 'marker.dart';
import 'package:flutter/material.dart';
import 'timeline.dart';
import 'globals.dart';
// A widget that edits a given image.
class EditImageScreen extends StatefulWidget {

  const EditImageScreen({super.key, required this.image, required this.marker});
  final ImageData image;
  final Marker marker;

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
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Timeline(indexOf: markers1.indexOf(marker))));
}
moveBack(context){
  Navigator.pop(context);
}