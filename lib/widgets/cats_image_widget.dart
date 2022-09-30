import 'dart:io';

import 'package:flutter/material.dart';

class CatsImage extends StatelessWidget {
  final String path;

  const CatsImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(path.isNotEmpty) {
      return Image.file(File(path));
    }
    else {
      return Image.asset("assets/placeholder.png");
    }
    
  }
}