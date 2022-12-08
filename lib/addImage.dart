import 'dart:developer';

import 'globals.dart';
import 'imageData.dart';
import 'marker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'editImage.dart';
import 'timeline.dart';

// a widget that allows users to choose how to add an image
class AddImageScreen extends StatelessWidget {
  const AddImageScreen({super.key, required this.marker, required this.currentGarden});

  final Marker marker;
  final int currentGarden;

  @override
  Widget build(BuildContext context){
    final bottomBarHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Center(
          child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height:30),
                const Text("This marker has no images yet!", style: TextStyle(fontSize: 20, color: Colors.black54)),
                const SizedBox(height:30),
                const Text("Choose how to add an image:", style: TextStyle(fontSize: 15, color: Colors.black54)),
                const SizedBox(height:30),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed:() async {
                         ImageData image = await addImage(true, marker,context);
                         final navigator = Navigator.of(context);

                         //moveToEditImage(context, image, marker);
                        },
                        style: ElevatedButton.styleFrom(
                          shape : const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Icon(Icons.camera_alt,size:54),
                      ),
                      const SizedBox(width:30),
                      ElevatedButton(
                        onPressed:() async {
                          ImageData image = await addImage(false, marker,context);

                          //moveToEditImage(context, image, marker);
                        },
                        style: ElevatedButton.styleFrom(
                          shape : const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Icon(Icons.add_photo_alternate,size:54),
                      ),
                    ]),
              ])
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xff054f20),
            boxShadow: const [
            ],
          ),
          height: bottomBarHeight,
          child: Align(
            alignment: Alignment.center,
            child: Text(marker.name,style: TextStyle(fontSize: 25, color: Colors.white))
          ),
        )
    );
  }
}

//adds image to images list and moves to edit screen of that image
addImage(bool useCamera, Marker marker,BuildContext context) async{
  final navigator = Navigator.of(context);
  XFile? image;
  if(useCamera)
    {image = await ImagePicker().pickImage(source: ImageSource.camera);}
  else
    {image = await ImagePicker().pickImage(source: ImageSource.gallery);}
  if(image == null) return;
  final now = DateTime.now();
  int markerIndex = markers1.indexOf(marker);
  ImageData i = ImageData(imagePath: image.path,date: now,markerIndex: markerIndex);
  if(currentGarden == 1){
    images1[markers1.indexOf(marker)].add(i);
  }
  else{
    images2[markers2.indexOf(marker)].add(i);
  }
  navigator.push(MaterialPageRoute(
      builder: (context) => EditImageScreen(image: i, marker: marker, currentGarden: currentGarden,)));
}