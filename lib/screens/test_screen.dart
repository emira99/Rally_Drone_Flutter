
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(home: 
           Scaffold(
                        body: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
              return
               Center(child: Container(color: Colors.amber,));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
              return 
              Center(child: Container(color: Colors.greenAccent,child: Text('connections'),));
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return 
          Center(child: Container(color: Colors.redAccent,));
        },
      ),
           ),
    );
  }
}


// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';

// // void main() {
// //   runApp(MyAPP());
// // }

// // class MyAPP extends StatefulWidget {
// //   @override
// //   _MyAPPState createState() => _MyAPPState();
// // }

// // class _MyAPPState extends State<MyAPP> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Application(),
// //     );
// //   }
// // }

// class Application extends StatefulWidget {
//   // lib core الاساسية لربط الاتصال
//   // Application({this.app});
//   // final FirebaseApp app;

//   @override
//   _ApplicationState createState() => _ApplicationState();
// }

// class _ApplicationState extends State<Application> {
//   String _displayText = '2';
// // lib databaseلربط مع الداتا بيز real time علشان اضع داتا بها
//   final referenceDatase = FirebaseDatabase.instance.reference();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getdata();
//   // }
  

//   StreamController streamController = StreamController();

//   Future getdata() async {
//     final resalt = await referenceDatase
//     // .child('output/temp').onValue.listen((event) {
//     //     final Object? temp = event.snapshot.value ;
//     //     streamController.add(DataSnapshot);
//     // });
//         .child('output').child('temp')
//       //   once().then((snapshot) {
//       // streamController.add(snapshot); });
        
//         //   final Object? temp = event.snapshot.value ;
         
//         // });
//         .once().then(
//           streamController.(value) {
            
//           }(SnapshotMetadata) );

//     return resalt;
//   }

//   @override
//   void initState() {
//     streamController = StreamController();

//     Timer.periodic(Duration(seconds: 1), (_) => getdata());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Stack(
//         // HDtfJg.jpg
//                   children: [
//                      Image.asset(
//                   'lib/tesla_app/images/HDtfJg.jpg',
//                   filterQuality: FilterQuality.high,
//                   fit: BoxFit.cover,
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//       ListView(
//         children: [
//             SizedBox(height: 100
//             ,),
//             Column(
//               children: [
//                 StreamBuilder(
//                     stream: streamController.stream,
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                      
//                       if (snapshot.hasData) {
//                         dynamic t_temp = 23;
//                       double t = 0.1;
//                       t_temp = snapshot.data;

//                       if (t_temp <= 10.01) {
//                         t = 0.1;
//                       } else if (t_temp <= 25.01) {
//                         t = 0.2;
//                       } else if (t_temp <= 27.01) {
//                         t = 0.2;
//                       } else if (t_temp <= 35) {
//                         t = 0.3;
//                       } else if (t_temp <= 45) {
//                         t = 0.4;
//                       } else if (t_temp <= 55) {
//                         t = 0.5;
//                       } else if (t_temp <= 66) {
//                         t = 0.6;
//                       } else if (t_temp <= 77) {
//                         t = 0.7;
//                       } else if (t_temp <= 88.01) {
//                         t = 0.8;
//                       } else if (t_temp <= 90.01) {
//                         t = 0.9;
//                       } else if (t_temp <= 110) {
//                         t = 0.99;
//                       } else if (t_temp >= 110) {
//                         t = 0.99;
//                         t_temp = 110;
//                       }
//                         return Column(children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 0, top: 0),
//                             child:
//                              GFProgressBar(
//                               leading: Text(
//                                 'Temp',
//                                 style: TextStyle(
//                                   fontSize: 25,
//                                   color: Color(0xFFFBE200),
//                                 ),
//                               ),
//                               progressBarColor: Color(0xFFFAF600),
//                               backgroundColor: Color(0xFFFDFDFD),
//                               width: 10, //width of the Progress bar
//                               mask:
//                                   MaskFilter.blur(BlurStyle.solid, 3), //شادو للملئ
//                               radius: 170, //حجم الدائرة
//                               animateFromLastPercentage: true,
//                               circleWidth: 6.0,
//                               autoLive: true,
//                               animation: true,
//                               percentage: t, //كام في المية  %%%
//                               trailing: Text('${t_temp} C',
//                                   style: TextStyle(
//                                       color: Color(0xFFF0EBEA),
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold)),
//                               type: GFProgressType.circular,
//                               circleStartAngle: 0.0, //بداية الملئ
//                               progressHeadType: GFProgressHeadType.circular,
//                             ),
//                           ),
//                         ]);
//                       } else {
//                         return Column(children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 0, top: 0),
//                             child: GFProgressBar(
//                               leading: Text(
//                                 'Temp',
//                                 style: TextStyle(
//                                   fontSize: 25,
//                                   color: Color(0xFFFBE200),
//                                 ),
//                               ),
//                               progressBarColor: Color(0xFFFAF600),
//                               backgroundColor: Color(0xFFFDFDFD),
//                               width: 10, //width of the Progress bar
//                               mask:
//                                   MaskFilter.blur(BlurStyle.solid, 3), //شادو للملئ
//                               radius: 170, //حجم الدائرة
//                               animateFromLastPercentage: true,
//                               circleWidth: 6.0,
//                               autoLive: true,
//                               animation: true,
//                               percentage: .1, //كام في المية  %%%
//                               trailing: GFLoader(
//                                 loaderstrokeWidth: 4.0, //حجم الدوران في  الاندرويد
//                                 duration:
//                                     Duration(milliseconds: 1000), //سرعة التحميل
//                                 size: GFSize
//                                     .LARGE, //حجم في circle.ios .android. square
//                                 type: GFLoaderType.android,
//                               ),

//                               type: GFProgressType.circular,
//                               circleStartAngle: 0.0, //بداية الملئ
//                               progressHeadType: GFProgressHeadType.circular,
//                             ),
//                           ),
//                         ]);
//                       }
//                     })
//               ],
//             )
//         ],
//       ),
//     ],
//         ),
//     );
//   }
// }



// /*

// */
