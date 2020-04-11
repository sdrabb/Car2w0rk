
import 'package:flutter/material.dart';

class AddTripScreenWidget extends StatefulWidget {
  AddTripScreenWidget({this.value: 1.0});

  final double value;

  @override
  AddTripState createState() => new AddTripState(value);
}

class AddTripState extends State<AddTripScreenWidget> {
  AddTripState(this._value);
  double _value;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  String dropdownDriverValue = 'Andrea';
  String dropdownPassenger1Value = 'Andrea';
  String dropdownPassenger2Value = 'Andrea';
  String dropdownPassenger3Value = 'Andrea';
  String dropdownPassenger4Value = 'Andrea';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Add Trip'),
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
                  items: <String>['Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
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
                  items: <String>['Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
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
                  items: <String>['Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
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
                  items: <String>['Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
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
                  items: <String>['Andrea', 'Francesco', 'Daniele', 'Fabio', 'Alberto']
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
        onPressed: () => _displaySnackBar(context),
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

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}