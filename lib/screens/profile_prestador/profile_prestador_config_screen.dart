import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder_app/controller/auth_controller.dart';
import 'package:profinder_app/models/app_user.dart';
import 'package:profinder_app/utils/my_colors.dart';

class ProfilePrestadorConfigScreen extends StatefulWidget {
  const ProfilePrestadorConfigScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePrestadorConfigScreen> createState() =>
      _ProfilePrestadorConfigScreenState();
}

class _ProfilePrestadorConfigScreenState
    extends State<ProfilePrestadorConfigScreen> {
  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> categoryControllers =
      List.generate(5, (index) => TextEditingController());
  final TextEditingController descriptionController = TextEditingController();
  // Agrega una nueva propiedad para las imágenes seleccionadas
  List<XFile>? images;
  List<String> imageUrls = [];

// Utiliza un ImagePicker para permitir al usuario seleccionar imágenes
  final ImagePicker _picker = ImagePicker();

  String? mainCategory;
  Future<DocumentSnapshot<Map<String, dynamic>>>? futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> selectImages() async {
    try {
      images = await _picker.pickMultiImage();
    } catch (e) {
      print(e);
    }
    if (images != null) {
      for (var image in images!) {
        if (image.path != null) {
          File file = File(image.path);
          var snapshot = await FirebaseStorage.instance
              .ref()
              .child(
                  'users/${FirebaseAuth.instance.currentUser!.uid}/images/${image.name}')
              .putFile(file);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(downloadUrl);
          setState(() {
            imageUrls = imageUrls;
          });
        } else {
          print('Error: la ruta de la imagen es nula');
        }
      }
    } else {
      print('Error: no se seleccionaron imágenes');
    }
  }

  Future<Image> _loadImage(String url) async {
    return Image.network(url, fit: BoxFit.fill);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          var userData = snapshot.data!;
          var serviceData = userData['service'];
          descriptionController.text = serviceData['description'];
          mainCategory = userData['mainService'];
          imageUrls = serviceData['images'].cast<String>();

          for (var i = 0; i < categoryControllers.length; i++) {
            categoryControllers[i].text = serviceData['categories'][i];
          }
          return Scaffold(
            backgroundColor: MyColors.lightGreen,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 100, top: 50),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Configuración de Perfil de Prestador',
                        style: TextStyle(
                          color: MyColors.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(
                          5,
                          (index) => Column(
                                children: [
                                  TextFormField(
                                    controller: categoryControllers[index],
                                    decoration: InputDecoration(
                                      labelText: 'Habilidad ${index + 1}',
                                      labelStyle: const TextStyle(
                                          color: MyColors.primary,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.primary,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.primary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor introduzca texto';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          labelStyle: TextStyle(
                              color: MyColors.primary,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.primary,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduzca texto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('serviceCategories')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return DropdownButtonFormField<String>(
                            value: mainCategory,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.id,
                                child: Text(document['name']),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'Servicio Principal',
                              labelStyle: TextStyle(
                                  color: MyColors.primary,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.primary,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                mainCategory = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor seleccione una opción';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      //boton para seleccionar imagenes
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: const MaterialStatePropertyAll(
                              MyColors.secondary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                color: MyColors.primary,
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(300, 50),
                          ),
                        ),
                        onPressed: () {
                          selectImages();
                        },
                        child: const Text(
                          'Seleccionar Imágenes',
                          style: TextStyle(
                            color: MyColors.primary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      imageUrls.isEmpty
                          ? const SizedBox(height: 0)
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: imageUrls.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: _loadImage(imageUrls[index]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Image> image) {
                                    if (image.connectionState ==
                                        ConnectionState.done) {
                                      return image.data!;
                                    } else if (image.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return const Icon(Icons.error);
                                    }
                                  },
                                );
                              },
                            ),

                      const SizedBox(height: 40),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor:
                              const MaterialStatePropertyAll(MyColors.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                color: MyColors.secondary,
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(160, 60),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'service': {
                                'categories': categoryControllers
                                    .map((controller) => controller.text)
                                    .toList(),
                                'description': descriptionController.text,
                                'images': imageUrls,
                              },
                              'mainService': mainCategory,
                            }).then((value) {
                              Get.snackbar(
                                '¡Éxito!',
                                'Se ha actualizado su perfil',
                                backgroundColor: MyColors.secondary,
                                colorText: MyColors.primary,
                              );
                            });
                          }
                        },
                        child: const Text(
                          'GUARDAR',
                          style: TextStyle(
                            color: MyColors.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
