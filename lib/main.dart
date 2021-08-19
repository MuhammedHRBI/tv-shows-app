  
import 'package:flutter/material.dart';
import 'package:tv_shows_app/home.dart';
import 'package:tv_shows_app/loading.dart';

void main() => runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));