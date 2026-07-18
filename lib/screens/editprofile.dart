import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/user.dart';
import 'package:task_flow/providers/userprovider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  File? image;
  final _imagepicker = ImagePicker();
  late AppUser? appuser;

@override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FD),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff0D47A1),
            size: 30,
          ),
        ),

        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0xff102A56),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black54, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GestureDetector(
           behavior: HitTestBehavior.opaque,
           onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Selector<Userprovider, AppUser?>(
                      selector: (_, provider) => provider.user,
                      builder: (context, user, child) {
                        appuser = user;
                        nameController.text = appuser!.name!;
                        emailController.text = appuser!.email!;
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
                            backgroundImage: image == null
                                ? user!.profileimg != null
                                      ? NetworkImage(user.profileimg!)
                                      : null
                                : FileImage(image!),
                            child: user!.profileimg == null && image == null
                                ? const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Color.fromARGB(255, 94, 92, 92),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
          
                    Positioned(
                      bottom: 0,
                      right: -5,
                      child: GestureDetector(
                        onTap: () async {
                          var imagex = await _imagepicker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (imagex != null) {
                            setState(() {
                              image = File(imagex.path);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: const BoxDecoration(
                            color: Color(0xff0D47A1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          
                /// Full Name
                const Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4A4A5A),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 18, color: Color(0xff102A5C)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xffC8D0E7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xffC8D0E7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: Color(0xff0D47A1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 28),
          
                /// Email Address
                const Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4A4A5A),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                TextFormField(
                  controller: emailController,
                  enabled: false,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: const Color(0xffEEF2FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xffD8E2FF)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xffD8E2FF)),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                const Text(
                  "Email address is managed by your organization.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
          
                const SizedBox(height: 40),
          
                /// Save Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try{
                       String url  = await context.read<Userprovider>().uploadProfileImage(image!);                                 
                      final updateuser = appuser!.copyWith(
                        email: emailController.text,
                        name: nameController.text,
                        profileimg: url,
                      );        
                       if(!context.mounted){
                        return;
                       }                                  
                        context.read<Userprovider>().updateUser(updateuser);                         
                          Navigator.pop(context);
                        
                      } catch (e) {
                        if(!mounted){
                          return ;
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    icon: const Icon(Icons.save_outlined, color: Colors.white),
                    label: const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0D47A1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
