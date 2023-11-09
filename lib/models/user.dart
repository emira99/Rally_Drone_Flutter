import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String avnum;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.avnum,
      required this.followers,
      required this.following ,
      });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      avnum: snapshot['avnum'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "avnum": avnum,
        "followers": followers,
        "following": following,
      };
}



// import 'package:cloud_firestore/cloud_firestore.dart';

// class User {
//   final String email;
//   final String uid;
//   final String photoUrl;
//   final String username;
//   final String bio;
//   final List followers;
//   final List following;

//   const User ({
//     required this.email,
//     required this.uid,
//     required this.photoUrl,
//     required this.username,
//     required this.bio,
//     required this.followers,
//     required this.following,
//   });

 

//   static User fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     // as Map<String, dynamic>;
//     return User(
//       username: snapshot['username'],
//       uid: snapshot['uid'],
//       email: snapshot['email'],
//       photoUrl: snapshot['photoUrl'],
//       bio: snapshot['bio'],
//       followers: snapshot['followers'],
//       following: snapshot['following'], 
//     ); 
//   }
//    Map<String, dynamic> toJson() => {
//     "username": username ,
//     "uid": uid,
//     "email": email,
//     "photoUrl": photoUrl ,
//     "bio": bio, 
//     "followers": followers ,
//     "following": following , 
//   };
// }