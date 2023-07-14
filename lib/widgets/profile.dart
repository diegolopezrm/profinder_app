import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder_app/controller/profile_controller.dart';
import 'package:profinder_app/models/app_user.dart';
import 'package:profinder_app/utils/my_colors.dart';
import 'dart:io';
import 'dart:math';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key}) : super(key: key);
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
}

  void pickUploadImage() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75, 
      );

      Reference ref = FirebaseStorage.instance.ref().child('${generateRandomString(15)}.jpg');

      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'profilepic': value});
        });
      });
  }
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    String calculateAge(DateTime birthDate) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age.toString();
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              AppUser userData = snapshot.data as AppUser;
              return Column(children: [
                Container(
                  //La caja verde donde esta la imagen de perfil y el nombre
                  height: 350,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      //gradiente
                      colors: [
                        MyColors.primary,
                        Color.fromARGB(255, 25, 115, 116)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.3, 0.8],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              pickUploadImage();
                            },
                            child: CircleAvatar(
                            backgroundColor: MyColors.secondary,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: userData.profilepic == ' ' ? const NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png') : NetworkImage(userData.profilepic!),
                            ),
                          ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${userData.name!} ${userData.lastName!}',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ultima conexion: ${userData.lastConnection!.day.toString()}/${userData.lastConnection!.month.toString()}/${userData.lastConnection!.year.toString()}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: MyColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      const Text(
                        'Informacion personal:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: const Text(
                          'Edad',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${calculateAge(userData.birthday!)} años',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          'Correo',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          'Telefono',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          userData.phoneNumber!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          'Direccion',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          userData.address!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text('Algo salio mal'));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
