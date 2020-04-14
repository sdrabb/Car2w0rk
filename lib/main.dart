

import 'package:car2work/team_manager.dart';
import 'package:flutter/material.dart';


import 'package:car2work/add_trip.dart';
import 'package:car2work/view_stat.dart';
import 'package:car2work/credits.dart';

void main() {
  runApp(new NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {

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
      onGenerateRoute: null,
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  @override
  FirstScreenState createState() => new FirstScreenState();
}

class FirstScreenState extends State<FirstScreenWidget> {
  String _teamId = 'f26d60305dae929ef8640a75e70dd78ab809cfe9';
  var _value = 50.0;


  _navigateToAddTrip() async {

    _value = await Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) => new AddTripScreenWidget(_teamId)
        )
    ) ?? 1.0;
  }

  _navigateViewStat() async {

    _value = await Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) => new ViewStatScreenWidget(_teamId)
        )
    ) ?? 1.0;
  }

  _navigateCredits() async {

    _value = await Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) => new CreditscreenWidget(_teamId)
        )
    ) ?? 1.0;
  }

  _navigateToTeamManager() async {

    _value = await Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) => new TeamManagerScreenWidget(_teamId)
        )
    );
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text('Car2Work'),
        bottom: PreferredSize(
            child: Text("Team id: " + _teamId,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.yellowAccent,
              ),
            ),
            preferredSize: null
        ),
      ),
      body: new ListView(
      //padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
          child: ListTile(
            leading: null,
            title: Text('View Stats'),
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
            title: Text('Add Trip'),
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
        Card(
          child: ListTile(
            leading: null,
            title: Text('Credits'),
            trailing:  Icon(
              Icons.assignment,
              color: Colors.blue,
              size: 36.0,
            ),
            onTap: () {
              _navigateCredits();
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: null,
            title: Text('Team Manager'),
            trailing:  Icon(
              Icons.group,
              color: Colors.blue,
              size: 36.0,
            ),
            onTap: () {
              _navigateToTeamManager();
            },
          ),
        )
      ]
    )
  );
  }
}





