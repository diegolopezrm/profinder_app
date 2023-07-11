import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:profinder_app/utils/my_colors.dart';
import '../controller/auth_controller.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  DateTime _birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightGreen,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text(
                    'Registra tu información',
                    style: TextStyle(
                      color: MyColors.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  )),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre.';
                  }
                  if (value.length < 2) {
                    return 'El nombre debe tener al menos 2 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu apellido.';
                  }
                  if (value.length < 2) {
                    return 'El apellido debe tener al menos 2 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu número de teléfono.';
                  }
                  final phoneRegExp = RegExp(r'^\d{10}$');
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Por favor ingresa un número de teléfono válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu dirección.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform(
                    transform: Matrix4.skewX(-0.05),
                    origin: const Offset(50.0, 50.0),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: TextButton(
                          onPressed: () async {
                            final DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _birthday,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _birthday = selectedDate;
                              });
                            }
                          },
                          child: const SizedBox(
                            width: 150,
                            child: Text(
                              'Selecciona tu fecha de nacimiento',
                              style: TextStyle(
                                color: MyColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      DateFormat.yMd().format(_birthday) ==
                              DateFormat.yMd().format(DateTime.now())
                          ? ''
                          : DateFormat.yMd().format(_birthday),
                      style: const TextStyle(
                        color: MyColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Transform(
                transform: Matrix4.skewX(-0.05),
                origin: const Offset(50.0, 50.0),
                child: Material(
                  color: MyColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(_authController.user!.uid)
                              .set({
                            'name': _nameController.text,
                            'lastName': _lastNameController.text,
                            'phoneNumber': _phoneNumberController.text,
                            'address': _addressController.text,
                            'birthday': _birthday,
                            'lastConnection': DateTime.now(),
                            'interests': [],
                            'onboarding': false,
                          }).then((value) {
                            Get.offNamed(AppRoutes.mainScreen);
                          }).catchError((error) {
                            log('Error: $error');
                          });
                        }
                      },
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
