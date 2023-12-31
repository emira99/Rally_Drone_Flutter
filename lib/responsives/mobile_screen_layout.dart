// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finala/providers/user_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ffi';

import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/utiles/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:finala/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
 int _page = 0 ;
 late PageController pageController ;

 @override
 void initState() {
   super.initState();
   pageController = PageController();
 }

 @override
 void dispose() {
  super.dispose();
  pageController.dispose();
 }

 void navigationTapped(int page) {
    pageController.jumpToPage(page);
 }

 void onPageChanged(int page ) {
   setState(() {
     _page = page;
   });
 }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems, 
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
          bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home , 
                color: _page == 0 ? blueColor : secondaryColor ,
                ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search , 
                color: _page == 1 ? blueColor : secondaryColor ,),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle , 
              color: _page == 2 ? blueColor : secondaryColor ,),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.airplanemode_active, 
                color: _page == 3 ? blueColor : secondaryColor ,),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person, 
                color: _page == 4 ? blueColor : secondaryColor ,),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTapped,
          ),
    );
  }
}

//  String username = "";

//   @override
//   void initState() {
//     super.initState();
//     getUsername();
//   }

//   void getUsername() async {
//    DocumentSnapshot snap = await FirebaseFirestore.instance
//    .collection('users')
//    .doc(FirebaseAuth.instance.currentUser!.uid)
//    .get();

//    setState(() {
//      username = (snap.data() as Map<String, dynamic>)['username']; 
//    });
//    }