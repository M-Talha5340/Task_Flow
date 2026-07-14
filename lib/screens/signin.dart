// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/firbaseservices/service.dart';
import 'package:task_flow/screens/forgotpassword.dart';
import 'package:task_flow/screens/navbar.dart';
import 'package:task_flow/screens/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
 bool rememberMe = false;
  bool obscurePassword = true;
  final _formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validatePassword(String? val) {
    if (val!.isEmpty) {
      return "Enter Password";
    } else {
      bool hasUppercase = false;
      bool hasLowercase = false;
      bool hasDigit = false;
      bool hasSpecialChar = false;
      for (int i = 0; i < val.length; i++) {
        String char = val[i];

        if (char.contains(RegExp(r'[A-Z]'))) {
          hasUppercase = true;
        }
        if (char.contains(RegExp(r'[a-z]'))) {
          hasLowercase = true;
        }
        if (char.contains(RegExp(r'[0-9]'))) {
          hasDigit = true;
        }
        if (char.contains(RegExp(r'[@$!%#^*?&]'))) {
          hasSpecialChar = true;
        }
      }
      if (val.length < 4) {
        return "Must be atleast 4 characters";
      }
      if (!hasUppercase) {
        return "Must contain at least one uppercase letter";
      }

      if (!hasLowercase) {
        return "Must contain at least one lowercase letter";
      }

      if (!hasDigit) {
        return "Must contain at least one number";
      }

      if (!hasSpecialChar) {
        return "Must contain at least one special character";
      }
    }
    return null;
  }
  String? isValidEmail(String? email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
    if (email!.isEmpty){
      return "Enter Email";
    }
    if(emailRegex.hasMatch(email)){
         return null;
    }
    return "Invalid Email Formate";
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FC),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
           child: 
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        /// Logo
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xffDDE4FF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.lock_person_outlined,
                        size: 45,
                        color: Color(0xff0D47A1),
                      ),
                    ),
        
                    const SizedBox(height: 15),
        
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff102A5C),
                      ),
                    ),
        
                    const SizedBox(height: 5),
        
                    Text(
                      "Please enter your details to    Sign In",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 18,
                      ),
                    ),
        
                    const SizedBox(height: 25),
        
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 10),
        
                    TextFormField(
                       controller: emailController,
                       validator: isValidEmail,
                      decoration: InputDecoration(
                        hintText: "abc@company.com",
                        prefixIcon: const Icon(Icons.mail_outline),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 15),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: 
                            (context) => ForgotPasswordScreen()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color(0xff0D47A1),
                            ),
                          ),
                        )
                      ],
                    ),
        
                    TextFormField(
                      obscureText: obscurePassword,
                      validator: validatePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Ab@123",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
        
        
                    const SizedBox(height: 15),
        
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0D47A1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  try {
                                    
                                        await Service.instance.signIn(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                   if (!context.mounted) {
                                      return;
                                    }
                                    
                                  
                                   
                                  } on FirebaseAuthException catch (e) {
                                    String message = "";
                                    switch (e.code) {
                                       case "invalid-credential":
                                        message = "Please enter valid cridential.";
                                        break;

                                      case "wrong-password":
                                        message =
                                            "Incorrect Password.";
                                        break;                                                                         

                                      case "network-request-failed":
                                        message =
                                            "Please check your internet connection.";
                                        break;

                                      default:
                                        message =                                        
                                            "Something went wrong.";
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text(message)));
                                  }
                                }},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 15),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: 
                            (context)=> const SignUpScreen()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xff0D47A1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}