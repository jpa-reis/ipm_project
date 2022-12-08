import 'dart:core';


class ImageData{
  final DateTime date;
  final int markerIndex;
  final String imagePath;
  String description = "";
  bool community = false;

   ImageData({required this.imagePath,
    required this.date,
    required this.markerIndex});

   DateTime getDate(){
     return date;
   }
   int getMarkerIndex(){
     return markerIndex;
   }
   String getImagePath(){
     return imagePath;
   }
   String getDescription() {
     return description;
   }
   void setDescription(String newDescription){
     description = newDescription;
   }
   bool getCommunity(){
     return community;
   }
   void setCommunity(bool newCommunity){
     community = newCommunity;
   }
}