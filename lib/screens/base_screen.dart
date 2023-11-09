import 'package:finala/screens/h.dart';
import 'package:finala/screens/home_screen.dart';
import 'package:finala/screens/map2_screen.dart';
import 'package:finala/screens/radar_screen.dart'; 
import 'package:finala/screens/settings_screen.dart';
import 'package:finala/screens/test_screen.dart';
import 'package:finala/screens/weather_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
 const  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  int _selectedIndex = 0; 

  navigateTo(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomAppBarIcon({required int index , required IconData icon}){
    return IconButton
    (onPressed: () {
      navigateTo(index);
    },
     icon: Icon(
       icon,
       color: _selectedIndex == index ? kPrimaryColor : null ,
       ),
     iconSize: 35 , 
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Container(
            height: 70,
            color: kBottomAppBarColor ,
            child: Material(
              type: MaterialType.transparency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  IconButton(
                //   onPressed: (){}, 
                //   icon: Icon(Icons.home_rounded),
                //   iconSize: 35,
                // ),
                _bottomAppBarIcon(index : 0, icon: Icons.home_rounded), 
                _bottomAppBarIcon(index : 1, icon: Icons.camera_sharp),
                // IconButton(
                //   onPressed: (){}, 
                //   icon: Icon(Icons.bar_chart_rounded),
                //   iconSize: 35,
                // ),
                SizedBox(
                  width: 80 , 
                  height: 80 , 
                  child: Stack(
                    clipBehavior: Clip.none,
                    children:[
                     Positioned(
                       bottom: 20,
                    child:Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: buttonGradient
                      ),
                        child: IconButton(
                          iconSize: 48,
                          onPressed: (){} , 
                          icon: Icon(
                            Icons.map_rounded ,
                           color: Colors.white,
                          ))),
                     ),
                    ],
                  ),
                ),
                _bottomAppBarIcon(index : 2, icon: Icons.bar_chart_rounded),
                _bottomAppBarIcon(index : 3, icon: Icons.radar),
                // IconButton(
                //   onPressed: (){}, 
                //   icon: Icon(Icons.settings),
                //   iconSize: 35,
                // ),
                // IconButton(
                //   onPressed: (){}, 
                //   icon: Icon(Icons.account_circle_rounded),
                //   iconSize: 35,
                // ),
                
        
              ],
            ),
          ),
          ),
        ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: kBackGroundGradient
          ),
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              HomeScreen(),
              
              MapSample(),
              SettingScreen(),
              // Application() ,
              // HoomeScreen(),
              // Temp(),
            ],
          ),
        ),
    );
  }
}