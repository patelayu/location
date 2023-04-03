
import 'package:flutter/material.dart';
import 'package:locater3/screen/homepage.dart';
import 'package:locater3/screen/mappage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const HomePage(),
        "Map" : (context) => const MapPage(),
      },
    ),
  );
}