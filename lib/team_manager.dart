import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class TeamManagerScreenWidget extends StatefulWidget {
  String _teamId;
  TeamManagerScreenWidget(this._teamId);

  @override
  TeamManagerState createState() => new TeamManagerState(_teamId);
}

class TeamManagerState extends State<TeamManagerScreenWidget> {
  String _teamId;
  TeamManagerState(this._teamId);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Credit> _credits = <Credit>[];

  @override
  void initState() {
    super.initState();
    print(this._teamId);
  }


  _changeStyle(int credits){
    if(credits>0)
      return TextStyle(fontWeight: FontWeight.normal, color: Colors.green);
    else if(credits == 0)
      return TextStyle(fontWeight: FontWeight.normal, color: Colors.blue);
    else
      return TextStyle(fontWeight: FontWeight.normal, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Team Manager'),
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
          itemCount: _credits.length,
          itemBuilder: (context, index) =>
              Card(
                child: ListTile(
                  leading: null,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: _credits[index].subject
                            , style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\t credits: ' + _credits[index].credits.toString(),
                            style: _changeStyle(_credits[index].credits) ),
                      ],
                    ),
                  )
                  ,
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: _credits[index].label,
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
//                  trailing: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Icon(
//                        Icons.airport_shuttle,
//                      ),
//                      PopupMenuButton<int>(
//                        onSelected: null,
//                        itemBuilder: (context) =>
//                        [
//                          PopupMenuItem(
//                            value: 1,
//                            child: Text("Remove"),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
                  onTap: () {
                    null;
                  },
                ),
              ),
        ),
        floatingActionButton: FloatingActionButton.extended(
//        onPressed: () => _displaySnackBar(context),
          onPressed: () => null,
          label: Text('Save Team Settings'),
          icon: Icon(Icons.done),
          backgroundColor: Colors.pink,
        ),
      );
}


class Credit {
  String subject;
  String label;
  int credits;

  Credit.fromJSON(Map<String, dynamic> jsonMap) :
        subject = jsonMap['subject'],
        label = jsonMap['label'],
        credits = jsonMap['credits'];

}

Future<Stream<Credit>> getCredit() async {
  final String url = 'http://ec2-3-8-39-157.eu-west-2.compute.amazonaws.com:3000/computeCredits';

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Credit.fromJSON(data));
}