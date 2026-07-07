import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});
   final _formkey = GlobalKey<FormState>();
   final emailController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FC),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10,),                                        
                    
                    // Logo
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xff0D47A1),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: .25),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    const Text(
                      "TaskFlow",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0B2A60),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Main Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0B2A60),
                            ),
                          ),
                    
                          const SizedBox(height: 15),
                    
                          const Text(
                            "Enter your email to receive a password reset link.\nWe'll help you get back to your flow.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              height: 1.5,
                            ),
                          ),
                    
                          const SizedBox(height: 15),
                    
                          const Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    
                          const SizedBox(height: 12),
                    
                          TextFormField(
                             controller: emailController,
                             validator: isValidEmail,
                            decoration: InputDecoration(
                              hintText: "abc@company.com",
                              prefixIcon:
                                  const Icon(Icons.mail_outline, size: 28),
                              filled: true,
                              fillColor: const Color(0xffF7F8FD),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                    
                          const SizedBox(height: 20),
                    
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
                              onPressed: () {
                                 if(_formkey.currentState!.validate()){

                                 }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Send Reset Link",
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
                    
                          const SizedBox(height: 30),
                    
                          Divider(color: Colors.grey.shade300),
                    
                          const SizedBox(height: 10),
                    
                          Center(
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xff0D47A1),
                              ),
                              label: const Text(
                                "Back to Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff0D47A1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(text: "Need help? "),
                          TextSpan(
                            text: "Contact Support",
                            style: TextStyle(
                              color: Color(0xff0D47A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
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