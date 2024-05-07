import 'package:flutter/material.dart';
import 'package:helloworld/screens/first.dart';
import 'package:helloworld/screens/map.dart';
import 'package:helloworld/screens/second.dart';
import 'package:helloworld/screens/settings_screen.dart';
import 'package:helloworld/widgets/navigation_rails.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MAD helloworld',
      debugShowCheckedModeBanner: false,
      home: NavRailMenu(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class NavRailMenu extends StatefulWidget {
  @override
  _NavRailMenuState createState() => _NavRailMenuState();
}

class _NavRailMenuState extends State<NavRailMenu> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    FirstScreen(),
    SecondScreen(),
    SettingsScreen(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text('Mad Flutter App'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRailWidget(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
