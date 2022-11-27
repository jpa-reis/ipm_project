library my_prj.globals;

import 'package:flutter/material.dart';
import 'gardens.dart';
import 'imageData.dart';
import 'timeline.dart';
import 'marker.dart';

enum PhotoModes{
  private,
  public,
}

PhotoModes mode = PhotoModes.private;

const List<Garden> gardens = [
  Garden(name: 'Jardim Botânico de Lisboa', page: Timeline(indexOf: 1,)),
  Garden(name: 'Jardim Zoológico', page: Timeline(indexOf: 1,)),
  Garden(name: 'Estufa Fria', page: Timeline(indexOf: 1,))
];

List<Marker> markers = [
  const Marker(position: Offset(200.0, 200.0), name: "Rose"),
  const Marker(position: Offset(54.75, 200.0), name: "Tree")
];

final images = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
