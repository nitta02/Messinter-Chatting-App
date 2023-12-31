// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:messinter_app/screens/home_screen.dart';
import 'package:messinter_app/utils/firebase_utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:messinter_app/widgets/custom_button.dart';
import 'package:messinter_app/widgets/textform.dart';

class RegisterScreen extends StatefulWidget {
  void Function()? onTap;
  RegisterScreen({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  //user signUP
  void userSignUp() async {
    //userSignUpAuthentication
    final signUpAuth = Provider.of<FirebaseUtils>(context, listen: false);
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password not match')));
    } else {
      try {
        await signUpAuth
            .signUpwithEmailAndPassword(emailController.text.toString(),
                passwordController.text.toString())
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              const Icon(
                Icons.message,
                size: 80,
              ),
              30.heightBox,
              //text
              const Text(
                "Messinter",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              25.heightBox,
              CustomTextForm(
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                ),
                controller: emailController,
                obscureText: false,
              ),

              15.heightBox,
              CustomTextForm(
                hintText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock_open_rounded,
                ),
                controller: passwordController,
                obscureText: true,
              ),

              15.heightBox,
              CustomTextForm(
                hintText: 'Confirm Password',
                prefixIcon: const Icon(
                  Icons.lock_open_rounded,
                ),
                controller: confirmpasswordController,
                obscureText: true,
              ),
              15.heightBox,

              //signin button
              CustomButton(
                text: 'Sign Up',
                onTap: userSignUp,
              ),
              25.heightBox,

              //not member
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a Member?'),
                  5.widthBox,
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
