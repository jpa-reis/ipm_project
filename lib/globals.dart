library my_prj.globals;

import 'package:flutter/material.dart';
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
  const Marker(position: Offset(200.0, 200.0), page: Timeline())
];
