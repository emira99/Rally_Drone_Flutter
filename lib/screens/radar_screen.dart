// import 'package:finala/tesla_app/configs/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RadarScreen extends StatefulWidget {
//   // RadarScreen({Key? key}) : super(key: key);

//   @override
//   State<RadarScreen> createState() => _RadarScreenState();
// }

// class _RadarScreenState extends State<RadarScreen> {
//   late GoogleMapController _mapController ;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mobileBackgroundColor,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height  * 0.20,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('lib/tesla_app/images/Q.png'),
//                 alignment: Alignment.centerLeft,
//                 fit: BoxFit.cover,
//               )
//             ),
//           ),

//           SafeArea(child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 15),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
                  //  Text('Flight Radar'.toUpperCase(),
                  //  style: Theme.of(context).textTheme.caption.copyWith(
                  //    fontWeight: FontWeight.bold,
                  //    fontSize: 28,
                  //    color: Colors.blue,
                  //  )), 
                  //  Text('RealTime flight tracker'.toUpperCase(),
                  //  style: Theme.of(context).textTheme.caption.copyWith(
                  //    fontWeight: FontWeight.bold,
                  //    fontSize: 28,
                  //    color: Colors.blue,
                  //  )),
                   

//                  ],

//                ),
//              )
//            ],
//           ),)
//         ],
//       ),
//     );
//   }
// }