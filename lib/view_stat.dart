import 'package:flutter/material.dart';

class ViewStatScreenWidget extends StatefulWidget {
  ViewStatScreenWidget({this.value: 1.0});

  final double value;

  @override
  ViewStatState createState() => new ViewStatState(value);
}

class ViewStatState extends State<ViewStatScreenWidget> {
  ViewStatState(this._value);
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
      body: null,
      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () => _displaySnackBar(context),
        label: Text('Save your trip'),
        icon: Icon(Icons.done),
        backgroundColor: Colors.pink,
      ),
    );
  }

}