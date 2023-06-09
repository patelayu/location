import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../global/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  permissions() async {
    await Permission.location.request();
  }

  @override
  void initState() {
    permissions();
    super.initState();
  }

  Placemark? area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.withOpacity(0.4),
      ),
      backgroundColor: Colors.green.withOpacity(0.01),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${Global.latitude} , ${Global.longitude}",style: TextStyle(color: Colors.white),),
            OutlinedButton(
              onPressed: () async {
                Geolocator.getPositionStream().listen((e) {
                  setState(() {
                    Global.latitude = e.latitude;
                    Global.longitude = e.longitude;
                  });
                });
              },
              child: Text("Get location"),
            ),
            Text("$area",style: TextStyle(color: Colors.white),),
            OutlinedButton(
              onPressed: () async {
                List<Placemark> placeMark = await placemarkFromCoordinates(
                    Global.latitude, Global.longitude);
                setState(() {
                  area = placeMark[0];
                });
              },
              child: Text("Get Area"),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: () async {
                  setState(() {
                    Global.mapLocation =
                    "https://www.google.co.in/search?q=$Global.lat,$Global.long";
                  });
                  Navigator.pushNamed(context,"Map");},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Get Live Locations"),
                    Icon(Icons.location_on_outlined,color: Colors.green,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}