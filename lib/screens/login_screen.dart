import 'package:finala/resources/auth_methods.dart';
import 'package:finala/screens/signup_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/tesla_app/configs/utils.dart';
import 'package:finala/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

import '../responsives/mobile_screen_layout.dart';
import '../responsives/responsive_screen_layout.dart';
import '../responsives/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false ;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose(); 
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true ; 
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text, 
      password: _passwordController.text,
      );

      if(res == "success") {
        Navigator.of(context).pushReplacement(
         MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
               mobileScreenLayout: MobileScreenLayout(), 
               webScreenLayout: WebScreenLayout(),
               ),
      ),
      );
      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen(
      //  )));
      }else {
        showSnackBar(res, context);
      }
      setState(() {
        _isLoading = false;
      });
  }
  void navigateToSignup(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignupScreen(),),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2,),
              //image logo
              Image.asset('lib/tesla_app/images/H.png' , height:37,),
              const SizedBox(height: 64,),
              //text field input for email 
              TextFieldInput(textEditingController: _emailController,
               textInputType: TextInputType.emailAddress,
                hintText: 'Enter your email'),
                const SizedBox(height: 24,),
              //text field input for password
               TextFieldInput(textEditingController: _passwordController,
               textInputType: TextInputType.text,
                hintText: ('Enter your password'),
                isPass: true ),
                const SizedBox(height: 24,),
              //button login
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                   ? const Center(
                     child: CircularProgressIndicator(
                       color: primaryColor,
                     ),) 
                     : const Text('Log in '),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                      ),
                  ),
                  color: blueColor
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              Flexible(child: Container(), flex: 2,),
              //Transitioning to signing up

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8,),
                  ),
                   GestureDetector(
                     onTap: navigateToSignup,
                     child: Container(
                      child: Text("Sign up.", style: TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8,),
                  ),
                   )
                ],
              )


            ],
          ),)),
    );
  }
}