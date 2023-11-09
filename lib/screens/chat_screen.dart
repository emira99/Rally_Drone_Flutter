import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser ; //this will give us the email
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final messageTextController = TextEditingController();
 final _auth = FirebaseAuth.instance;
 
 String? messageText;  //this will give us the message 

 @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

 void getCurrentUser() {
   try {
   final user = _auth.currentUser ;
   if (user != null ) {
     signedInUser = user ;
     print(signedInUser.email);
   }
   }catch (e) {
     print(e);
   }
 }

//  void getMessages() async {
//    final messages = await _firestore.collection('messages').get();
//    for ( var message in messages.docs) {
//      print(message.data());
//    }
//  }


// void messagesStreams() async {
//    await for (var snapshot in _firestore.collection('messages').snapshots()) {
//    for ( var message in snapshot.docs) {
//      print(message.data());
//    }
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        
        title: Row(
          children: [
            Image.asset('lib/tesla_app/images/H.png', height: 17),
            SizedBox(width: 10),
            // Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // add here logout function
              _auth.signOut();
              Navigator.pop(context);
              
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 250, 17, 1),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value ;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();  
                      _firestore.collection('messages').add({
                      'text' : messageText , 
                      'sender': signedInUser.email,
                      //AutofillHints.username
                      'time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context , snapshot) {
                List<MessageLine> messageWidgets = [];

                if (!snapshot.hasData) {
                  //add here a spinner
                  return Center(child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),);
                }

                final messages = snapshot.data!.docs.reversed;
                for ( var message in messages) {
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final currentUser = signedInUser.email ; 

                  // if(currentUser == messageSender) {
                  //   //the code of the message from the signed in user 
                  // }
                  final messageWidget = MessageLine(
                    sender: messageSender, text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  messageWidgets.add(messageWidget); 
                }

                return 
                Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                    children: messageWidgets, 
                  ),
                );
              },
            );
  }
}


class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isMe ,  Key? key}) : super(key: key);

  final String? sender ;
  final String? text ;
  final bool isMe ; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender', style: TextStyle(fontSize: 12 , color: Colors.white)),
       Material(
         elevation: 5,
         borderRadius: isMe ? BorderRadius.only(
           topLeft: Radius.circular(30),
           bottomLeft:Radius.circular(30),
           bottomRight: Radius.circular(30),
         ) :
         BorderRadius.only(
           topRight: Radius.circular(30),
           bottomLeft:Radius.circular(30),
           bottomRight: Radius.circular(30),
         ),
        color: isMe ? Color.fromARGB(255, 21, 146, 255) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
          child: Text(
            '$text' , 
            style: TextStyle(fontSize: 15 , color: isMe ?  Colors.white : Colors.black45)),
        )),
      ])  );
  }
}









// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finala/screens/feed_screen.dart';
// import 'package:finala/widgets/message.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class chatpage extends StatefulWidget {
//   String email;
//   chatpage({required this.email});
//   @override
//   _chatpageState createState() => _chatpageState(snap: email);
// }

// class _chatpageState extends State<chatpage> {
//   // String snap;
//   _chatpageState({
//     // required this.snap
//     });

//   final fs = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final TextEditingController message = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'data',
//         ),
//         actions: [
//           MaterialButton(
//             onPressed: () {
//               _auth.signOut().whenComplete(() {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FeedScreen(),
//                   ),
//                 );
//               });
//             },
//             child: Text(
//               "signOut",
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.79,
//               child: messages(
//                 email: email,
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: message,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.purple[100],
//                       hintText: 'message',
//                       enabled: true,
//                       contentPadding: const EdgeInsets.only(
//                           left: 14.0, bottom: 8.0, top: 8.0),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.purple),
//                         borderRadius: new BorderRadius.circular(10),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.purple),
//                         borderRadius: new BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {},
//                     onSaved: (value) {
//                       message.text = value!;
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     if (message.text.isNotEmpty) {
//                       fs.collection('Messages').doc().set({
//                         'message': message.text.trim(),
//                         'time': DateTime.now(),
//                         'email': email,
//                       });

//                       message.clear();
//                     }
//                   },
//                   icon: Icon(Icons.send_sharp),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }