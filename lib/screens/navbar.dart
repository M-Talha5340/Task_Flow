import 'package:flutter/material.dart';
import 'package:task_flow/screens/calender.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/profile.dart';
import 'package:task_flow/widgets/custombottomnav.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<Navbar> {
 
  int selectedIndex = 0;

   List<Widget> screens = [Home(),CalendarScreen(),Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(             
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),     
       backgroundColor: const Color(0xffF5F6FC),
      appBar: AppBar(
        title: const Text(
          "TaskFlow",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D47A1),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, size: 34, color: Colors.black87),
        ),
        actions: [
          
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=32"),
          ),
        ],
      ),
      body: screens[selectedIndex], 
    
    );
  }
}
