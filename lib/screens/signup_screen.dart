import 'dart:typed_data';

import 'package:finala/resources/auth_methods.dart';
import 'package:finala/responsives/responsive_screen_layout.dart';
import 'package:finala/screens/login_screen.dart';
import 'package:finala/tesla_app/configs/colors.dart';
import 'package:finala/tesla_app/configs/utils.dart';
import 'package:finala/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../responsives/mobile_screen_layout.dart';
import '../responsives/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _avnumController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose(); 
    _passwordController.dispose();
    _avnumController.dispose();
    _usernameController.dispose();
  }

void selectImage() async{
Uint8List im = await pickImage(ImageSource.gallery);
setState(() {
  _image = im ;
});
}

void signUpUser() async {
  setState(() {
    _isLoading = true;
  });
  String res = await AuthMethods().signUpUser(
   email: _emailController.text , 
   password: _passwordController.text,
   username: _usernameController.text,
   avnum: _avnumController.text,
   file: _image!,                 
 ); 

setState(() {
   
   _isLoading = false; 
 });  

 if (res != 'success') {
   showSnackBar(res, context);
 }  else{
   Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
               mobileScreenLayout: MobileScreenLayout(), 
               webScreenLayout: WebScreenLayout(),
               ),
      ),
      );
 }
       
}
 void navigateToLogin(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),),
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
              Image.asset('lib/tesla_app/images/H.png' , height:35,),
              const SizedBox(height: 44,),
              // circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                  ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                  : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg'),
                  ),
               
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  )),
                ],
              ),
                const SizedBox(height: 24,),
              //text field input for username
              TextFieldInput(textEditingController: _usernameController,
               textInputType: TextInputType.text,
                hintText: 'Enter your username'),
                const SizedBox(height: 24,),

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

                //text field for id avion
                TextFieldInput(textEditingController: _avnumController,
               textInputType: TextInputType.text,
                hintText: 'Enter your ID AirCraft'),
                const SizedBox(height: 24,),

              //button login
              InkWell(
                onTap: signUpUser , 
                child: Container(
                  child: _isLoading 
                  ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )

                  : const Text('Sign up'),
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
                     onTap: navigateToLogin,
                     child: Container(
                      child: Text("Login.", style: TextStyle(fontWeight: FontWeight.bold,),
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