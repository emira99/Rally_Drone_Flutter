 import 'package:finala/providers/user_provider.dart';
import 'package:finala/responsives/mobile_screen_layout.dart';
import 'package:finala/responsives/responsive_screen_layout.dart';
import 'package:finala/responsives/web_screen_layout.dart';
import 'package:finala/screens/base_screen.dart';
import 'package:finala/screens/chat_screen.dart';
import 'package:finala/screens/login_screen.dart';
import 'package:finala/screens/signup_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:'AIzaSyBYglV6PsO3OFX_UsACKQ5nsMnqZnIwWHQ',
     appId: '1:344508113760:web:c4ada1f612df571c603405' ,
      messagingSenderId: '344508113760',
       projectId: 'avioav-app-bf5cc' , 
       storageBucket: 'avioav-app-bf5cc.appspot.com'),
  );
  }else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final _auth = FirebaseAuth.instance;
  const MyApp({Key? key}) : super(key: key);

  // this widget is the root of your applications
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false ,
        title: 'avionav demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor, 
        ),
       
        home:
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData) {
                return const ResponsiveLayout(
                 mobileScreenLayout: MobileScreenLayout(), 
                 webScreenLayout: WebScreenLayout(),
                 );
              } else if(snapshot.hasError) {
                return Center( 
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return  const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          } ),
        
      ),
    );
  }
}

