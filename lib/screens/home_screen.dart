import 'package:finala/tesla_app/configs/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _bat ="5";
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
      _displayText = '$valeur';
    });
   
  });
   _database.child('battery/health').onValue.listen((event) {
    final Object? val3= event.snapshot.value;
    setState(() {
      _bat = '$val3';
    });
   
  });
  
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
      
      child: Container(
        
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          
          Material(
            type: MaterialType.transparency,
            child: Row(
              children: [
                Image.asset('lib/tesla_app/images/H.png' , height:27,), 
              Spacer(),
              Stack(
                children: [
                  IconButton(
                    iconSize: 40,
                    splashRadius: 25,
                    onPressed: () {} , 
                    icon: FittedBox( child: Icon( Icons.account_circle_rounded))), 
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: kPrimaryColor , shape: BoxShape.circle),
                    ),
                  )
                ],
              )
              ],
            ),
          ),
           Text( 'Your AirCraft', style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
           
           Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 35),
            child: Text('MODEL RALLY' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w400),),
            ),
            Image.asset('lib/tesla_app/images/1png.png'),
            SizedBox(height: 10.0,),
            
             new CircularPercentIndicator(
                radius:60.0,
                lineWidth: 10.0,
                animation: true,
                percent: 0.8  ,
                
                center: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children:[  Text(
                  _bat,
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text('Power', style: TextStyle(fontWeight: FontWeight.bold,),
              
                 ) ],
                    ),
                    ),

                
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: kPrimaryColor,
                backgroundColor: kProgressBackGroundColor,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children:[
              //     SvgPicture.asset('lib/tesla_app/images/svgu.svg'), 
              //     Padding(padding: const EdgeInsets.only(right: 25),
              //     child: Text('power 17 min') ,)
                  
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Card(
                       
                        color: kCardColor,
                        elevation: 10 ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:SizedBox(
                          width: 120,
                          
                      
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Temperature', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Moteur'),
                            SizedBox(height: 10,),
                            Center(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                text:_displayText , style: TextStyle(
                                  fontSize: 50 , 
                                  fontWeight: FontWeight.bold, 
                                  color: kPrimaryColor
                                )
                            ),
                            WidgetSpan(
                              child:Transform.translate(offset: Offset(0 , -12),
                              child: Text('C',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)
                            ),
                            )
                              ),
                              ]),
                            ),
                            )
                
                          ],
                        ),
                        ),
                      ),
                      ),
                      
                      SizedBox(width: 20,),
                      Card(color: kCardColor,
                        elevation: 10 ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:SizedBox(
                          width: 120,
                          
                      
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Consumption', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Today'),
                            SizedBox(height: 10,),
                            Center(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                text:'4.3', style: TextStyle(
                                  fontSize: 50 , 
                                  fontWeight: FontWeight.bold, 
                                  color: kPrimaryColor
                                )
                            ),
                          
                              ]),
                            ),
                            )
                
                          ],
                        ),
                        ),
                      ),
                      ),
                       
                    ],
                  ),
                ),
              )
          
         
        ],
        ),
      ),
    ),
    );
  }
}