import 'package:flutter/material.dart';

Image Logoimage(String imagename) {
  return Image.asset(
    imagename, fit: BoxFit.fitWidth, width: 250, height: 150, );
}