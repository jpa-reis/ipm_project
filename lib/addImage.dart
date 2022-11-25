import 'marker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'editImage.dart';

// a widget that allows users to choose how to add an image
class AddImageScreen extends StatelessWidget {
  const AddImageScreen({super.key, required this.marker});

  final Marker marker;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
          child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height:30),
                const Text("Choose how to add an image:"),
                const SizedBox(height:30),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed:() async {
                          String imagePath = await getImageCamera();
                          moveToEditImage(context, imagePath, marker);
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
                          String imagePath = await getImageGallery();
                          moveToEditImage(context, imagePath, marker);
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
      bottomNavigationBar: BottomAppBar(
          color: Colors.lightGreen,
          child: Text(
            marker.getName(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          )),
    );
  }
}

getImageCamera()async{
  final image = await ImagePicker().pickImage(source: ImageSource.camera);
  if(image == null) return;
  return image.path;
}

getImageGallery()async{
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
  return image.path;
}

moveToEditImage(context, String imagePath, Marker marker) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditImageScreen( imagePath: imagePath,marker : marker)));
}