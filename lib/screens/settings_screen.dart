import 'package:finala/tesla_app/configs/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:flutter/animation.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen
({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _displayText = "2";
  String _oilpr ="1";
  String _level ="3";
  String _bat ="5";
  String _oiltemp="4";
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
 _database.child('Temp/oil processeur').onValue.listen((event) {
    final Object? val= event.snapshot.value;
    setState(() {
      _oilpr = '$val';
    });
   
  });
  _database.child('Temp/fuel level tank1').onValue.listen((event) {
    final Object? val1= event.snapshot.value;
    setState(() {


      _level = '$val1';
    });
   
  });
  _database.child('Temp/oil temperature').onValue.listen((event) {
    final Object? val2= event.snapshot.value;
    setState(() {
      _oiltemp = '$val2';
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

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 25,
                    splashRadius: 25,
                     icon:
                      Icon(Icons.arrow_back_ios_outlined ,
                      color: Colors.white,
                      )),
                    Text('Diagnostics', style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text('RALLY MODEL',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    
                      
                ],
              ),
              SizedBox(height: 20.0 ,),


              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: kCardGradient
              ),
              child:Column(
               
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    SizedBox( width: double.maxFinite,
                    height: 400,
                    child: Stack(
                    children: [
                      
                      Positioned(
                        top: 0,
                        left:0,
                        child: Text('Overall Health', style: TextStyle(fontWeight: FontWeight.bold),)),
                       
                      // Spacer(),
                      Positioned(
                        top: 0,
                        right: 0,
                        
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle ,
                            gradient: buttonGradient
                          ),
                          child: IconButton(
                            iconSize: 30,
                            onPressed: (){},
                            icon: Icon(Icons.restart_alt_rounded,
                            color: Colors.white,),
                          ),
                        ),
                      ),
             Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Stack(
                      children: [ 
                        Positioned.fill(child: Center(
                          child: Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor
                            ),
                          ),
                        ),),
                        Center(

                          child: SizedBox(
                            // width: 300,
                            // height: 300,
                           
                            child: CustomRipple()
                            ),
                            
                          ),

                          // Positioned(
                          //   top:90,
                          //   right: 60,
                          //   child: SizedBox(
                          //     width: 70,
                          //   height: 70,
                          //     child: CustomRipple())),

                          // Positioned(
                          //   top:95,
                          //   right: 80,
                          //   child: SizedBox(
                          //     width: 30,
                          //   height:30,
                          //     child: CustomRipple())),

                        //   Positioned(
                        //     top:70,
                        //     left: 60,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),

                        //   Positioned(
                        //     top:195,
                        //     left: 80,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),
                        // Positioned(
                        //     bottom:70,
                        //     right: 60,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),

                        //   Positioned(
                        //     bottom:95,
                        //     right: 80,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),

                        //   Positioned(
                        //     bottom:70,
                        //     left: 60,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),

                        //   Positioned(
                        //     bottom:95,
                        //     left: 80,
                        //     child: SizedBox(
                        //       width: 70,
                        //     height: 70,
                        //       child: CustomRipple())),
                              
                      Center(
                     
                        child: SizedBox(
                        
                        height: 600,
                        child: Image.asset('lib/tesla_app/images/n11.png', 
                        fit: BoxFit.contain,),
                        ),
                      ),
                 
                      ],
                    ),
                  ),


           

                 
                    )
                    ],
                    ),
                    ),
                    Text('battery health',style: TextStyle(fontWeight: FontWeight.bold,)),
                    SizedBox(height: 10,),
                    LinearPercentIndicator(
                      animation: true ,
                      backgroundColor: kProgressBackGroundColor.withOpacity(0.5),
                      percent: 0.8,
                      lineHeight: 20,
                      animationDuration: 2500,
                      center: Text('$_bat%'),
                      linearGradient: LinearGradient(colors: [
                        kPrimaryColor , kSecondaryColor
                      ]),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10, bottom: 10),
                       child: Text('Sensors',style: TextStyle(fontWeight: FontWeight.bold,)),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                   
                        Sensor(value: 0.8, label: 'Moteur:$_displayText', ),
                        Sensor(value: 0.4, label: 'Batery temp:$_oilpr', ),
                        Sensor(value: 0.6, label: 'brakes:$_level', ),
                        Sensor(value: 0.9, label: 'Suspention', )
                      ],
                    )
                    ],
              ),
              )
           ],
        ),
      ),
      
       ),
    );
            
  }
}
  class Sensor extends StatelessWidget {
    const Sensor({Key? key, required this.value, required this.label}) : super(key: key);

    final double value ; 
    final double height = 100 ; 
    final String label ; 
  
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [ ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                            Container(
                            width: 38,
                            height: height,
                            color: kProgressBackGroundColor.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: height * value ,
                                  decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                     begin: Alignment.topCenter ,
                                     end: Alignment.bottomCenter,
                                     colors: buttonGradient.colors)
                                  ), 
                                  
                                )],
                                ),
                            ),
                           
                        ),
                        SizedBox(height: 5,),
                        Text(label)
        ],
      );
     
    }
  }

class CustomRipple extends StatefulWidget {
  CustomRipple({Key? key}) : super(key: key);

  @override
  State<CustomRipple> createState() => _CustomRippleState();
}

class _CustomRippleState extends State<CustomRipple> with SingleTickerProviderStateMixin{
 
 @override
 void initState() {
   _controller = AnimationController(vsync: this , duration: Duration(milliseconds: 1200));
   _animation = Tween<double>(begin: 0.4 , end: 0.6).animate(_controller)..addListener(() {
     setState(() {});
     });
     _controller.repeat();
   
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  late AnimationController _controller ;
  late Animation<double> _animation ;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
     child: Container(
      //  width: 300,
      //  height: 300,
       decoration: BoxDecoration(
         border: Border.all(color: kPrimaryColor , width: 8),
         shape: BoxShape.circle
       ),

    ),);
  }
}