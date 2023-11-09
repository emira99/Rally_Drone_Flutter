import 'package:finala/screens/add_post_screen.dart';
import 'package:finala/screens/base_screen.dart';
import 'package:finala/screens/feed_screen.dart';
import 'package:finala/screens/profile_screen.dart';
import 'package:finala/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600 ;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const  SearchScreen(),
  const AddPostScreen(),
  const BaseScreen() ,
  ProfilScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),

];