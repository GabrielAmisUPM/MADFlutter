import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/db/database_helper.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  @override
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    loadMarkers();
  }
// Function to laod list of markers from database
  Future<void> loadMarkers() async {
    final dbMarkers = await DatabaseHelper.instance.getCoordinates();
    List<Marker> loadedMarkers = dbMarkers.map((record) {
      return Marker(
        point: LatLng(record['latitude'], record['longitude']),
        width: 80,
        height: 80,
        child: Icon(
          Icons.location_pin,
          size: 60,
          color: Colors.red,
        ),
      );
    }).toList();
    setState(() {
      markers = loadedMarkers;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content(){
    return FlutterMap(
        options: const MapOptions(
            initialCenter: LatLng(40.38923590951672, -3.627749768768932),
            initialZoom: 15,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.doubleTapZoom | InteractiveFlag.drag | InteractiveFlag.all)
        ),
        children: [openStreetMapTileLayer,
        MarkerLayer(markers: [
            Marker(
            point: LatLng(40.38923590951672, -3.627749768768932),
        width: 80,
        height: 80,
        child: Stack(
          children: [
            const Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.yellow,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                child: const Text(
                  'You are here!',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
            ),
          const Marker(
              point: LatLng(40.38988743556828, -3.633014220376507),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              )
          ),
          const Marker(
              point: LatLng(40.39527505048739, -3.630359246796122),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.green,
              )
          ),
          const Marker(
              point: LatLng(40.39300371783269, -3.622394326054965),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.blue,
              )
          ),
        ])]
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
