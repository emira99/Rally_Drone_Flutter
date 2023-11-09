// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MyMapPage extends StatefulWidget {
//   MyMapPage({Key? key , this.title = ''}) : super(key: key);
//   final String title;

//   @override
//   State<MyMapPage> createState() => _MyMapPageState();
// }

// class _MyMapPageState extends State<MyMapPage> {

//   bool _isVisible = true;
//   bool _darkMode = false ; 
//    StreamSubscription _streamSubscription;
//   Location _tracker = Location();
//   Marker marker ;
//    Circle circle; 
//   GoogleMapController _googleMapController;

//   static final CameraPosition initialLocation = CameraPosition(
//     target: LatLng(51.511271 , -0.1517578),
//     zoom: 14.4746,); 
    
//     void showMenuOption(){
//       setState(() {
//         _isVisible = !_isVisible; 
//       });

//     }
//     Future<void> _launched;
//     String _phone ='911';

//     bool switchValue = false ; 


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         leading: new IconButton( icon: new Icon(Icons.menu), onPressed: () {},),),
      
//       body: Stack (
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: GoogleMap(
//               zoomGesturesEnabled: true,
//               initialCameraPosition: initialLocation ,
//               markers: Set.of((marker != null) ? [marker] : []),
//               circles: Set.of((circle != null) ? [circle] : []),
//               onMapCreated: (GoogleMapController  controller) {_googleMapController = controller ;}, 
//             ),

//           ),
//           Visibility(visible: _isVisible ,child: Container(
//             margin: EdgeInsets.only(top: 80 , right: 10),
//             alignment: Alignment.centerLeft,
//             color: Color(0xFF808080).withOpacity(0.5),
//             height: 440,
//             width: 70,
//             child: Column(children: <Widget>[
//               SizedBox(
//                 width: 10.0,
//               ),
//               new Switch(
//                 activeColor: Colors.black87,
//               onChanged: (newValue){
//                 // setState(() {
//                 //   this.switchValue = newValue ; 
//                 //   _darkMode = newValue ; 
//                 //   changeMapMode();
//                 //   print('change the map type ');


//                 // });
//                 value: switchValue,
//               },),
//               SizedBox(width: 10.0),
//               Padding(padding: const EdgeInsets.all(8.0),
//               child: FloatingActionButton(
//                 child: Icon(Icons.directions_bike),
//                 elevation:5,
//                 backgroundColor: Colors.greenAccent,
//                 onPressed: () {
//                   // setState(() {
//                   //  _darkMode = false;
//                   //  changeMapMode(); 
//                   // });
//                 },
//               )
//                ,),
//                SizedBox(width: 10.0),
//                Padding(padding: const EdgeInsets.all(8.0),
//                child: FloatingActionButton(
//                  child: Icon(Icons.location_searching),
//                  elevation: 5,
//                  backgroundColor: Colors.blueAccent,
//                  onPressed: () {
//                   //  getCurrentLocation();
//                  },
//                ),),
//                 SizedBox(width: 10.0),
//                Padding(padding: const EdgeInsets.all(8.0),
//                child: FloatingActionButton(
//                  child: Icon(Icons.local_taxi),
//                  elevation: 5,
//                  backgroundColor: Colors.orangeAccent,
//                  onPressed: () {
//                 //    getCurrentLocation();
//                  },
//                ),),
//                 SizedBox(width: 10.0),
//                Padding(padding: const EdgeInsets.all(8.0),
//                child: FloatingActionButton(
//                  child: Icon(Icons.notification_important, color: Colors.yellow,),
//                  elevation: 5,
//                  backgroundColor: Colors.purple[300],
//                  onPressed: () {
//                   //  getCurrentLocation();
//                  },
//                ),),
//                 SizedBox(width: 10.0),
//                Padding(padding: const EdgeInsets.all(8.0),
//                child: FloatingActionButton(
//                  child: Icon(Icons.phone,color: Colors.pinkAccent),
//                  elevation: 5,
//                  backgroundColor: Colors.white,
//                  onPressed: () => setState(() {
//                    _launched = _makePhoneCall('tel:$');
//                  })),
                  
                 
//                ),

              
//             ]),))
//         ],
//       ),
//     );
//   }
// }