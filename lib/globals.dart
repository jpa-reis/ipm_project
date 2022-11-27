library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:ipm_project/addImage.dart';
import 'imageData.dart';
import 'main.dart';
import 'timeline.dart';
import 'marker.dart';

enum PhotoModes{
  private,
  public,
}

PhotoModes mode = PhotoModes.private;

const List gardens = [
  {'title': "Jardim Botânico de Lisboa", 'navigate':  Timeline(indexOf: 1,)},
  {'title': "Jardim Zoológico", 'navigate':  Timeline(indexOf: 1,)},
  {'title': "Estufa Fria", 'navigate': Timeline(indexOf: 1,)}
];

List<Marker> markers = [
  const Marker(position: Offset(200.0, 200.0), name: ""),
  const Marker(position: Offset(54.75, 200.0), name: "")
];

final images = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
