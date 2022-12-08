import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';

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
                    Text(DateFormat('MM-dd').format(widget.image.date)),
                    const SizedBox(width: 60),
                    const Text("Community:"),
                    Switch(
                      value: communitySwitch,
                      onChanged: (value) {
                        setState((){communitySwitch = value;});
                      },
                      activeTrackColor: Colors.green,
                      activeColor: Color(0xff054f20),
                      inactiveTrackColor:Colors.grey,
                      inactiveThumbColor: Color(0xff054f20),
                    ),
                  ]
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: (){
          widget.image.setDescription(descriptionController.text);
          widget.image.setCommunity(communitySwitch);
          if(communitySwitch){
            if(currentGarden == 1){
              community1[markers1.indexOf(widget.marker)].add(widget.image);
            }
            else{
              community2[markers2.indexOf(widget.marker)].add(widget.image);
            }
          }
          else{
            if(currentGarden == 1){
              community1[markers1.indexOf(widget.marker)].remove(widget.image);
            }
            else{
              community2[markers2.indexOf(widget.marker)].remove(widget.image);
            }
          }
          moveToTimeline(context,widget.marker);
        },
        backgroundColor: Color(0xff054f20),
        child: const Icon(Icons.save),
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color:Color(0xff054f20),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
            ],
          ),
          height: bottomBarHeight,
          child: Align(
              alignment: Alignment.center,
              child: Text(widget.marker.name,style: TextStyle(fontSize: 25, color: Color(0xFFD3D3D3)))
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