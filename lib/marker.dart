import 'dart:core';
import 'package:flutter/material.dart';

class Marker {
  final Offset position;
  final Widget page;
  final String name;

  const Marker({
    required this.position,
    required this.page,
    required this.name});

  Offset getPosition() {
    return position;
  }

  Widget getPage() {
    return page;
  }

  String getName() {
    return name;
  }
}