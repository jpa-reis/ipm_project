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
  Garden(name: 'Jardim Botânico de Lisboa', id: 1),
  Garden(name: 'Estufa Fria', id: 2)
];

List<Marker> markers1 = [
  const Marker(position: Offset(2480.4, 1051.3), name: "Rose", id: 0),
  const Marker(position: Offset(840.3, 999.4), name: "Tree", id: 1),
  const Marker(position: Offset(1108.9, 898.4), name: "Tulip", id: 2)
];

List<Marker> markers2 = [
  const Marker(position: Offset(867.9, 815.6), name: "Orchid", id: 0),
  const Marker(position: Offset(966.2, 1196.6), name: "Daisy", id: 1),
  const Marker(position: Offset(1322.3, 1048.8), name: "Peaches", id: 2)
];

int currentGarden = 1;


final images1 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
final images2 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];

final community1 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];
final community2 = <List<ImageData>>[<ImageData>[], <ImageData>[], <ImageData>[]];