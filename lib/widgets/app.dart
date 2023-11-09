import 'package:finala/screens/base_screen.dart';
import 'package:flutter/material.dart';


class TeslaApp extends StatelessWidget {
  const TeslaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 101, 101, 101)),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white,),
        ),
      ),
      home: BaseScreen(),
    );
  }
}