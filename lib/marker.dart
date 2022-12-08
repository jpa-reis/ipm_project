import 'dart:core';
import 'package:flutter/material.dart';

class Marker {
  final Offset position;
  final String name;
  final int id;
  String description;

  Marker({
    required this.position,
    required this.name,
    required this.id,
    required this.description
  });

}