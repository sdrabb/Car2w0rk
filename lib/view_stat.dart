import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewStatScreenWidget extends StatefulWidget {
  String _teamId;
  ViewStatScreenWidget(this._teamId);

  @override
  ViewStatState createState() => new ViewStatState(_teamId);
}

class ViewStatState extends State<ViewStatScreenWidget> {
  String _teamId;
  ViewStatState(this._teamId);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Trip> _trips = <Trip>[];

  @override
  void initState() {
    super.initState();
    listenForTrips();
  }

  _removeTrip(String id) async {

    // set up PUT request arguments
    String url = 'http://ec2-3-8-39-157.eu-west-2.compute.amazonaws.com:3000/removeTrip';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"id": "' + id + '"}';
    // make PUT request
    print(json);
    http.Response response = await http.post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the updated item with the id added
    String body = response.body;

    final tripSavedERRORSnackBar = SnackBar(content: Text('error while removing'));

    if(response.statusCode == 200) {
      _trips.clear();
      listenForTrips();
    }
    else{
      _scaffoldKey.currentState.showSnackBar(tripSavedERRORSnackBar);
    }
  }



  void listenForTrips() async {

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
    body: ListView.builder(
      itemCount: _trips.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: null,
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: DateTime.parse(_trips[index].date).day.toString() + '-' +
                    DateTime.parse(_trips[index].date).month.toString() + '-' +
                    DateTime.parse(_trips[index].date).year.toString() + ' '
                    ,style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: _trips[index].id, style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          )
          ,
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                  Icons.airport_shuttle,
              ),
              PopupMenuButton<int>(
              onSelected: (context) => [_removeTrip(_trips[index].id)],
                itemBuilder: (context) =>[
                  PopupMenuItem(
                    value: 1,
                    child: Text("Remove"),
                  ),
                ],
              ),
            ],
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

  String id;
  String driver;
  String p1;
  String p2;
  String p3;
  String p4;
  String date;

  Trip.fromJSON(Map<String, dynamic> jsonMap) :

        id = jsonMap['_id'],
        driver = jsonMap['driver'],
        p1 = jsonMap['passenger1'],
        p2 = jsonMap['passenger2'],
        p3 = jsonMap['passenger3'],
        p4 = jsonMap['passenger4'],
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