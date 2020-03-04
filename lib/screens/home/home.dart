import 'package:flutter/material.dart';
import 'package:ghcensus_app/models/census_model.dart';
import 'package:ghcensus_app/screens/home/census.dart';
import 'package:ghcensus_app/services/auth.dart';
import 'package:ghcensus_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ghcensus_app/screens/home/census_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth= AuthService();
  @override
  Widget build(BuildContext context) {
    void _showCensusPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Census(),
        );
      });
    }

    return StreamProvider<List<census_model>>.value(
      value: DatabaseService().census,
      child: Scaffold(
        backgroundColor:  Colors.blueGrey[50],
        appBar:  AppBar(
          title: Text('CensusGH'),
          backgroundColor: Colors.blueGrey[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person,
                  color: Colors.white),
              label: Text('Logout',
              style: TextStyle(color: Colors.white ),),
              onPressed: () async{
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.message,
                  color: Colors.cyanAccent),
              label: Text('New Census',
                style: TextStyle(color: Colors.white ),),
              onPressed: () => _showCensusPanel(),
            )
          ],
        ),
        body: CensusList(),

      ),
    );
  }
}
