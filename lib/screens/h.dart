import 'package:firebase_database/firebase_database.dart';


import 'package:flutter/material.dart';

class Temp extends StatefulWidget {
  Temp({Key? key}) : super(key: key);

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
String _displayText = "2";
final _database = FirebaseDatabase.instance.reference();

@override
  void initState() {
    super.initState();
    _activateListenners();
  }

void _activateListenners() {
  _database.child('Temp/valeur').onValue.listen((event) {
    final Object? valeur = event.snapshot.value;
    setState(() {
      _displayText = 'Temp: $valeur C';
    });
   
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(height: 50,),
          Text(_displayText),
        ]),
      ),
    );
  }
}