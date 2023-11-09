
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finala/tesla_app/configs/storage_methods.dart';
import 'package:finala/models/user.dart' as model ;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance ; 


  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!; 

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap) ;
  }

  //sign up user 
  Future<String> signUpUser({
    required String email ,
    required String password ,
    required String username ,
    required String avnum ,
    required Uint8List file , 

  }) async { 
    String res = "Some error occurred"; 
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || avnum.isNotEmpty 
      // || file != null 
       ) {
        
          // register user
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

          print(cred.user!.uid);

          // StorageMethods().uploadImageToStorage('profilePics', file, false);

          String photoUrl = await  StorageMethods().uploadImageToStorage(
            'profilePics', file, false );
            
          // add user to our database
            model.User user = model.User(
              username: username ,
              uid:   cred.user!.uid,
              email: email ,
              avnum: avnum, 
              photoUrl: photoUrl,
              followers: [],
              following: [],
            );
// {
//             'username': username, 
//             'uid': cred.user!.uid,
//             'email': email, 
//             'avnum': avnum,
//             'photoUrl': photoUrl,
//             'following': [],
//             'followers': [],
//       }

          // model.User user = model.User(
           await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        //  await _firestore.collection("users").doc(cred.user!.uid).set( user.toJson());            
          res = "success";
      
      // }   else {
      //   res = "Please enter all the fields";
      }
    // } 
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = 'the email is badly formatted.';
    //   } else if(err.code == 'weak-password'){
    //     res = 'Password should be at least 6 characters';
      // }
    }
      catch(err) { 
      res = err.toString(); 
    }
    return res; 

  }
  //logging in user 
  Future<String> loginUser({
    required String email ,
    required String password , 
  }) async {
    String res = "Some error occurred"; 
    try {
      if( email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = "success";
      } else{
        res = "Please enter all the fields";
      }
    } 
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'wrong-password'){

    //   }
    // }
    catch(err){
      res = err.toString();
      // return err.toString();
    }
    return res ;

  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

