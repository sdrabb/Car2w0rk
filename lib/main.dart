

import 'package:flutter/material.dart';


import 'package:car2work/add_trip.dart';
import 'package:car2work/view_stat.dart';


void main() {
  runApp(new NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {


  Route<dynamic> _parseRoute(RouteSettings settings) {
    // Split up the path
    final List<String> path = settings.name.split('/');
    // First entry should be empty as all paths should start with a '/'
    assert(path[0] == '');
    // Only valid path is '/second/<double value>'
    if (path[1] == 'second' && path.length == 3) {
      final value = double.parse(path[2]);

      return new MaterialPageRoute<double>(
        settings: settings,
        builder: (BuildContext context) => new AddTripScreenWidget(value: value),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // The MaterialApp's home is automatically set as the bottom of the navigation stack
    return new MaterialApp(
      title: 'Navigation Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FirstScreenWidget(),
      // Manually parse routes requested through pushNamed() calls
      onGenerateRoute: _parseRoute,
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  @override
  FirstScreenState createState() => new FirstScreenState();
}

class FirstScreenState extends State<FirstScreenWidget> {
  var _value = 50.0;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _navigateToAddTrip() async {

    _value = await Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) => new AddTripScreenWidget(value: _value)
        )
    ) ?? 1.0;
  }

  _navigateViewStat() async {

    _value = await Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) => new ViewStatScreenWidget(value: _value)
        )
    ) ?? 1.0;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Car2Work'),
      ),
      body: new ListView(
      //padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
          child: ListTile(
            leading: null,
            title: Text('View stats'),
            trailing:  Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 36.0,
            ),
            onTap: () {
              _navigateViewStat();
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: null,
            title: Text('Add trip'),
            trailing:  Icon(
              Icons.directions_car,
              color: Colors.blue,
              size: 36.0,
            ),
            onTap: () {
              _navigateToAddTrip();
            },
          ),
        ),
      ]
    )
  );
  }
}





