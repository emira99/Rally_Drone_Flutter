import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finala/models/user.dart';
import 'package:finala/screens/chat_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/widgets/post_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'lib/tesla_app/images/H.png' , 
          height: 27,
        ),
        actions: [
          IconButton
            (onPressed: () 
            => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen())) ,
           
            icon: const Icon(
              Icons.messenger_outline , 
              // size: 30,
              ) ,)
        ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots()
          ,
          builder: (context,
           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(), 

              ),
            );
          } )
    );
  }
}