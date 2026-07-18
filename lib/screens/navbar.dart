
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/taskprovider.dart';
import 'package:task_flow/providers/userprovider.dart';
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

   late List<Widget> screens ;

    AppBar buildAppBar(){
      if (selectedIndex == 0 || selectedIndex == 1 ){
          return AppBar(
        title: const Text(
          "TaskFlow",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D47A1),
          ),
        ),
       
        actions: [                  
                 Selector<Userprovider, String?>(
                               selector: (_, provider) => provider.user!.profileimg,              
                               builder: (context, imgurl, child) {                
                                 return  CircleAvatar(
                    radius: 30,
                    backgroundImage: imgurl != null
                        ? NetworkImage(imgurl)
                        : null,
                    child: imgurl == null
                        ? const Icon(Icons.person, size: 80, color: Color.fromARGB(255, 94, 92, 92))
                        : null,
                  
                                 );
                               },
                             ),
         
        ],
      );
      }
        return   AppBar(
        title: const Text(
          "TaskFlow",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D47A1),
          ),
        ),
       
        actions: [
            PopupMenuButton<String>(            
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
            ),            
            offset: Offset(0,12),
            iconColor: Color(0xff0D47A1),              
            color: Colors.white,
            iconSize: 30,                        
            onSelected: (value) async{
              if (value == "Logout"){
                 context.read<Taskprovider>().clear();
                      context.read<Userprovider>().clearUser();
                      await FirebaseAuth.instance.signOut();
              }
            },
            itemBuilder: (context) => [              
              PopupMenuItem(
                value: "Logout",                
                child: Row(
                  children: [
                    Icon(Icons.logout,color:Color(0xff0D47A1),),                    
                    SizedBox(width: 10),
                    Text("Logout ",style: TextStyle(color: Color(0xff0D47A1)),),
                  ],
                ),
              ),
            ],
          ),
  
                  
        ],
      );
      
    }   
    
    @override
   void initState(){
        super.initState();
        screens =[Home(),CalendarScreen(),Profile()];
   }
   
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
      appBar: buildAppBar(),
      body: screens[selectedIndex], 
    
    );
  }
}
