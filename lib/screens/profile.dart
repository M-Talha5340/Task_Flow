import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/user.dart';
import 'package:task_flow/providers/taskprovider.dart';
import 'package:task_flow/providers/userprovider.dart';
import 'package:task_flow/screens/editprofile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();

  
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Selector<Userprovider, String?>(
              selector: (_, provider) => provider.user!.profileimg,              
              builder: (context, imgurl, child) {                
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xffDCE8FF),
                      width: 5,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: imgurl != null
                        ? NetworkImage(imgurl)
                        : null,
                    child: imgurl == null
                        ? const Icon(Icons.person, size: 80, color: Color.fromARGB(255, 94, 92, 92))
                        : null,
                  ),
                );
              },
            ),
      
            const SizedBox(height: 25),
      
            Selector<Userprovider, AppUser?>(
              selector: (_, provider) => provider.user,
              builder: (context, user, child) {
                return Text(
                  "${user!.name}",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff102A5C),
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
      
            const SizedBox(height: 8),
      
            Selector<Userprovider, AppUser?>(
              selector: (_, provider) => provider.user,
              builder: (context, user, child) {
                return Text(
                  "${user!.email}",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                );
              },
            ),
      
            const SizedBox(height: 30),
      
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfile()));
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0D47A1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
      
                const SizedBox(width: 15),
      
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      context.read<Taskprovider>().clear();
                      context.read<Userprovider>().clearUser();
                      await FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 1.5),
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
