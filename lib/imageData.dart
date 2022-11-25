import 'dart:core';
import 'package:flutter/material.dart';


class ImageData{
  final String date;
  final Offset markerPosition;
  final String imagePath;
  String description = "";
  bool community = false;

   ImageData({required this.imagePath,
    required this.date,
    required this.markerPosition});

   String getDate(){
     return date;
   }
   Offset getMarkerPosition(){
     return markerPosition;
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