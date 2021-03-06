
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTripScreenWidget extends StatefulWidget {
  String _teamId;
  AddTripScreenWidget(this._teamId);

  @override
  AddTripState createState() => new AddTripState(_teamId);
}

class AddTripState extends State<AddTripScreenWidget> {
  String _teamId;
  AddTripState(this._teamId);


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  String dropdownDriverValue = '';
  String dropdownPassenger1Value = '';
  String dropdownPassenger2Value = '';
  String dropdownPassenger3Value = '';
  String dropdownPassenger4Value = '';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        centerTitle: true,
        title: const Text('Add Trip'),
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
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
              child: ListTile(
                leading: null,
                title: Text('Driver'),
                trailing:  DropdownButton(
                  value: dropdownDriverValue,
                  icon: Icon(Icons.person),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownDriverValue = newValue;
                    });
                  },
                  items: <String>['', 'Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                onTap: () {
                  null;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: null,
                title: Text('Passenger 1'),
                trailing:  DropdownButton(
                  value: dropdownPassenger1Value,
                  icon: Icon(Icons.airline_seat_recline_normal),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownPassenger1Value = newValue;
                    });
                  },
                  items: <String>['', 'Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                onTap: () {
                  null;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: null,
                title: Text('Passenger 2'),
                trailing:  DropdownButton(
                  value: dropdownPassenger2Value,
                  icon: Icon(Icons.airline_seat_recline_normal),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownPassenger2Value = newValue;
                    });
                  },
                  items: <String>['', 'Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                onTap: () {
                  null;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: null,
                title: Text('Passenger 3'),
                trailing:  DropdownButton(
                  value: dropdownPassenger3Value,
                  icon: Icon(Icons.airline_seat_recline_normal),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownPassenger3Value = newValue;
                    });
                  },
                  items: <String>['', 'Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                onTap: () {
                  null;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: null,
                title: Text('Passenger 3'),
                trailing:  DropdownButton(
                  value: dropdownPassenger4Value,
                  icon: Icon(Icons.airline_seat_recline_normal),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownPassenger4Value = newValue;
                    });
                  },
                  items: <String>['', 'Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                onTap: () {
                  null;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: null,
                title: Text("Trip date:     " + "${selectedDate.toLocal()}".split(' ')[0]),
                trailing: RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select trip date'),
                ),
              ),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () => _displaySnackBar(context),
        onPressed: () => saveTrip(context),
        label: Text('Save your trip'),
        icon: Icon(Icons.done),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> saveTrip(BuildContext context) async {

    var reqBody = {};
    reqBody['driver'] = dropdownDriverValue;
    reqBody['passenger1'] = dropdownPassenger1Value;
    reqBody['passenger2'] = dropdownPassenger2Value;
    reqBody['passenger3'] = dropdownPassenger3Value;
    reqBody['passenger4'] = dropdownPassenger4Value;
    reqBody['date'] = selectedDate.toString();

    final http.Response response = await http.post(
      'http://ec2-3-8-39-157.eu-west-2.compute.amazonaws.com:3000/saveTrip',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(reqBody)
    );

    final tripSavedOKSnackBar = SnackBar(content: Text('trip saved!'));
    final tripSavedERRORSnackBar = SnackBar(content: Text('error while saving'));

//    print(response.statusCode );
//    print(response.body);
    if(response.statusCode == 200) {
      _scaffoldKey.currentState.showSnackBar(tripSavedOKSnackBar);
    }
    else{
      _scaffoldKey.currentState.showSnackBar(tripSavedERRORSnackBar);
    }
  }

}