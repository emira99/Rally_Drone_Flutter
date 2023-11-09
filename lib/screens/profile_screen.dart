import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finala/resources/auth_methods.dart';
import 'package:finala/resources/firestore_methods.dart';
import 'package:finala/screens/login_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/tesla_app/configs/utils.dart';
import 'package:finala/widgets/follow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilScreen extends StatefulWidget {
  final String uid ;
  const ProfilScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  var userData = {};
  int postLen = 0 ;
  int followers = 0 ;
  int following = 0 ;
  bool isFollowing = false ;
  bool isLoading = false ;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true ;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
      .collection('users')
      .doc(widget.uid)
      .get();
      // get post length
      var postSnap = await FirebaseFirestore.instance
      .collection('posts')
      .where('uid' , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

      postLen = postSnap.docs.length; 
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    }catch(e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(
      child: CircularProgressIndicator(),
    ) : Scaffold(
     appBar: AppBar(
       backgroundColor: mobileBackgroundColor,
       title: Text(userData['username'],),
       centerTitle: false,
     ), 
     body: ListView(
       children: [
         Padding(
           padding: const EdgeInsets.all(16),
         child: Column(
           children: [
             Row(
               children: [
                 CircleAvatar(
                   backgroundColor: Colors.grey,
                   backgroundImage: NetworkImage(
                     userData['photoUrl'],
                   ),
                  radius: 40,
                 ),
                 Expanded(
                   flex: 1,
                   child: Column(
                     children: [
                       Row(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           buildStateColumn(postLen, "posts"),
                           buildStateColumn(followers, "followers"),
                           buildStateColumn(following, "following"),
                         ],
                       ),
                        Row(
                        
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Expanded(child: 
                     FirebaseAuth.instance.currentUser!.uid == widget.uid?
                     FollowButton(
                       text: 'Sign Out',
                       backgroundColor: mobileBackgroundColor,
                       textColor: primaryColor,
                       borderColor: Colors.grey,
                       function: () async {
                         await AuthMethods().signOut();
                         Navigator.of(context).pushReplacement(
                           MaterialPageRoute(builder: (context) => 
                           const LoginScreen())
                         );
                       } ,
                     )
                     : isFollowing 
                     ? FollowButton(
                       backgroundColor: Colors.white,
                      borderColor: Colors.grey, 
                      text: 'Unfollow', 
                      textColor: Colors.black,
                      function: () async {
                        await FireStoreMethods().followUser(
                          FirebaseAuth.instance
                          .currentUser!.uid,
                           userData['uid'],);
                           setState(() {
                             isFollowing = false ;
                             followers--;
                           });
                      },
                      )
                      : FollowButton(
                        backgroundColor: mobileBackgroundColor, 
                        borderColor: Colors.grey, 
                        text:'Follow', 
                        textColor: primaryColor,
                        function: () async {
                          await FireStoreMethods().followUser(
                          FirebaseAuth.instance
                          .currentUser!.uid,
                           userData['uid'],);

                           setState(() {
                             isFollowing = true ;
                             followers++;
                           });
                        },)
                     ),
                   ],
                        
                 ),
                 
                     ],
                   ),
                 ),
               ],
                 ),
                
                 Container(
                   alignment: Alignment.centerLeft,
                   padding: const EdgeInsets.only(top: 10),
                   child: Text(userData['username'] , style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                   ),
                 ),
                 Container(
                   alignment: Alignment.centerLeft,
                   padding: const EdgeInsets.only(top: 1),
                   child: Text(userData['avnum'] ,
                   ),
                ),   
               ],
           
          
         ),
         ),
           const Divider(),
           FutureBuilder(
             
             future: FirebaseFirestore.instance
             .collection('posts')
             .where('uid', isEqualTo: widget.uid).
             get(),
             builder: (context, snapshot ) {
               if(snapshot.connectionState == ConnectionState.waiting){
                 return const Center(
                   child: CircularProgressIndicator(),
                 );
               }
               return Expanded(
                 child: GridView.builder(
                   shrinkWrap:  true,
                   itemCount: (snapshot.data! as dynamic).docs.length,
                   gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 3,
                     crossAxisSpacing: 3,
                     mainAxisSpacing: 1.5,
                     childAspectRatio: 1,
                   ) ,
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                      return Container(
                        child: Image(
                          image: NetworkImage(
                          snap['postUrl']
                        ),
                        fit: BoxFit.cover,),
                      );
                    }),
               );

           },)
       ],
     ),
    );
  }
  Column buildStateColumn (int num , String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),),

        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label, 
            style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 61, 180, 254)
          ),),
        )
      ],
    );
  }
}