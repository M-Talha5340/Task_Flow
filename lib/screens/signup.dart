import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/firbaseservices/service.dart';
import 'package:task_flow/screens/signIn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agree = false;
  bool obscurePassword = true;
  final _formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
    if (email!.isEmpty) {
      return "Enter Email";
    }
    if (emailRegex.hasMatch(email)) {
      return null;
    }
    return "Invalid Email Formate";
  }

  String? validateName(String? name) {
    if (name!.isEmpty) {
      return "Enter Name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FC),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Logo
                    Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        color: const Color(0xff0D47A1),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: .44),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "TaskFlow",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0D234F),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Master your productivity with professional\ngrade organization tools.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0D234F),
                            ),
                          ),

                          const SizedBox(height: 5),

                          TextFormField(
                            controller: nameController,
                            validator: validateName,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          TextFormField(
                            controller: emailController,
                            validator: isValidEmail,
                            decoration: InputDecoration(
                              hintText: "abc@company.com",
                              prefixIcon: const Icon(Icons.mail_outline),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          TextFormField(
                            obscureText: obscurePassword,
                            validator: validatePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
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
                                    UserCredential userCredential =
                                        await Service.signUp(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                    User u = userCredential.user!;
                                    print(u.uid);
                                    u.updateDisplayName(nameController.text);
                                    if (!context.mounted) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Account Created Successfully",
                                        ),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String message = "";
                                    switch (e.code) {
                                      case "email-already-in-use":
                                        message =
                                            "This email is already registered.";
                                        break;

                                      case "invalid-email":
                                        message = "Please enter a valid email.";
                                        break;

                                      case "weak-password":
                                        message =
                                            "Password should be at least 6 characters.";
                                        break;

                                      case "user-not-found":
                                        message =
                                            "No account found with this email.";
                                        break;

                                      case "wrong-password":
                                        message = "Incorrect password.";
                                        break;

                                      case "network-request-failed":
                                        message =
                                            "Please check your internet connection.";
                                        break;

                                      default:
                                        message =
                                            e.message ??
                                            "Something went wrong.";
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content: Text(message)));
                                  }
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create Account",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 18),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signin(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0D47A1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
