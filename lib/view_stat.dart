import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Trip> _trips = <Trip>[];

  @override
  void initState() {
    super.initState();
    listenForBeers();
  }

  void listenForBeers() async {

    final Stream<Trip> stream = await getBeers();

    stream.listen((Trip trip) =>
        setState(() =>  _trips.add(trip))
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Stats'),
    ),
    body: ListView.builder(
      itemCount: _trips.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: null,
          title: Text(DateTime.parse(_trips[index].date).day.toString() + '-' +
                      DateTime.parse(_trips[index].date).month.toString() + '-' +
                      DateTime.parse(_trips[index].date).year.toString() ),
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: _trips[index].driver + ' ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: _trips[index].p1 + ' '),
                TextSpan(text: _trips[index].p2 + ' '),
                TextSpan(text: _trips[index].p3 + ' '),
                TextSpan(text: _trips[index].p4 + ' '),
              ],
            ),
          ),
          trailing:  DropdownButton(
            value: null,
            icon: Icon(Icons.airport_shuttle),
            underline: Container(
              height: 0,
            ),
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
    ),
  );
}


class Trip {
  int retcode;
  String retDes;

  int id;
  String driver;
  String p1;
  String p2;
  String p3;
  String p4;
  String date;

  Trip.fromJSON(Map<String, dynamic> jsonMap) :

        id = jsonMap['id'],
        driver = jsonMap['driver'],
        p1 = jsonMap['p1'],
        p2 = jsonMap['p2'],
        p3 = jsonMap['p3'],
        p4 = jsonMap['p4'],
        date = jsonMap['date'];
}

Future<Stream<Trip>> getBeers() async {
  final String url = 'http://ec2-3-8-39-157.eu-west-2.compute.amazonaws.com:3000/getTrips';

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Trip.fromJSON(data));
}