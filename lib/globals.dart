library my_prj.globals;

import 'package:flutter/material.dart';
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
  {'title': "Jardim Botânico de Lisboa", 'navigate': Timeline()},
  {'title': "Jardim Zoológico", 'navigate': Timeline()},
  {'title': "Estufa Fria", 'navigate': Timeline()}
];

List<Marker> markers = [
  const Marker(position: Offset(200.0, 200.0), page: Timeline(), name: ""),
  const Marker(position: Offset(54.75, 200.0), page: Timeline(), name: "")
];

final images = <List<ImageData>>[
  <ImageData>[ImageData(imagePath: "jardim.png",date: "now",markerIndex: 1)],
  <ImageData>[],
];
