import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_flow/screens/authwrapper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

     @override
     void initState(){
        super.initState();
         Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Authwrapper(),
        ),
      );
    });
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            // Logo Card
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffAFC4FF),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xffAFC4FF),
                    size: 30,
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 25),
        
            // App Name
            const Text(
              "TaskFlow",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff0D47A1),
              ),
            ),
        
            const SizedBox(height: 8),
        
            // Subtitle
            const Text(
              "PRECISION PRODUCTIVITY",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 3,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}