import 'dart:core';
import 'package:flutter/material.dart';

class Marker {
  final Offset position;
  final String name;

  const Marker({
    required this.position,
    required this.name});

  Offset getPosition() {
    return position;
  }
  String getName() {
    return name;
  }
}