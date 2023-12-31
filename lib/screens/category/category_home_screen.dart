import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profinder_app/controller/tab_controller.dart';
import '../../controller/auth_controller.dart';
import '../../models/category.dart';
import '../../utils/my_colors.dart';

class CategoryHomeScreen extends StatefulWidget {
  const CategoryHomeScreen({super.key});

  @override
  State<CategoryHomeScreen> createState() => _CategoryHomeScreenState();
}

class _CategoryHomeScreenState extends State<CategoryHomeScreen> {
  //get user id
  final authController = Get.find<AuthController>();

  late Future<List<Category>> _categoriesFuture;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _getCategories();
  }

  Future<List<Category>> _getCategories() {
    return FirebaseFirestore.instance
        .collection('serviceCategories')
        .orderBy('name', descending: false)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
  }

  List<Category> _filterCategories(List<Category> categories) {
    if (_searchText.isEmpty) {
      return categories;
    }
    return categories
        .where((category) =>
            category.name!.toLowerCase().contains(_searchText.toLowerCase()) ||
            category.keywords!.any((keyword) =>
                keyword.toLowerCase().contains(_searchText.toLowerCase())))
        .toList();
  }

  //check if the user is prestador, if yes check if he has a service information, if not, show a message and a button to go to tab 3

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoriesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ha ocurrido un error: ${snapshot.error}'));
        } else {
          var categories = _filterCategories(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hola ${authController.user!.name}!',
                          style: const TextStyle(
                              color: MyColors.lightGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                       
                        const Text(
                          '¿Qué servicio necesitas?',
                          style: TextStyle(
                              color: MyColors.secondary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar servicio por nombre o palabra clave',
                      labelStyle:
                          TextStyle(color: MyColors.lightGreen, fontSize: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.lightGreen),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // change color of text when user types
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.lightGreen),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // change color of text when user types
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.lightGreen),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon:
                          Icon(Icons.search, color: MyColors.lightGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 100.0),
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                3, // Aumenta la cantidad de elementos por fila
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0),
                    itemBuilder: (context, index) {
                      var category = categories[index];
                      var icon = category.getIcon();
                      var name = category.name;
                      return InkWell(
                        onTap:
                            //go to category slection screen
                            () {
                          Get.toNamed('/category-selection',
                              arguments: category);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Agrega borde redondeado
                          ),
                          elevation: 5, // Agrega sombra
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                icon,
                                const SizedBox(height: 8.0),
                                Text(
                                  name!,
                                  textAlign: TextAlign.center,
                                  //if text is too long, it will be replaced with ellipsis. only two lines
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
