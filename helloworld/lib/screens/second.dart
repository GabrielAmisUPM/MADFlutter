import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}


class _SecondScreenState extends State<SecondScreen> {
  List<List<String>> _coordinates = [];

  @override
  void initState() {
    super.initState();
    _loadCoordinates();
  }

  Future<void> _loadCoordinates() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/gps_coordinates.csv');
    List<String> lines = await file.readAsLines();
    setState(() {
      _coordinates = lines.map((line) => line.split(';')).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _coordinates.length,
        itemBuilder: (context, index) {
          var coord = _coordinates[index];
          var formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.parse(coord[0])));
          return ListTile(
            title: Text('Timestamp: $formattedDate'),
            subtitle: Text('Latitude: ${coord[1]}, Longitude: ${coord[2]}'),
          );
        },
      ),
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  // This method is called right after initState the first time
  // the widget is built and when any dependencies of the InheritedWidget change.
    print("didChangeDependencies: Dependencies updated.");
  }
  @override
  void didUpdateWidget(SecondScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  // If the parent widget changes and has to rebuild this widget (because it needs to update the configuration),
  // this method is called with the old widget as an argument.
    print("didUpdateWidget: The widget has been updated from the parent.");
  }
  @override
  void dispose() {
  // This method is called when this state object is permanently removed.
    print("dispose: Cleaning up before the state is destroyed.");
    super.dispose();
  }
}
