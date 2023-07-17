import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../models/category.dart';

class CategoryHomeScreen extends StatefulWidget {
  const CategoryHomeScreen({super.key});

  @override
  State<CategoryHomeScreen> createState() => _CategoryHomeScreenState();
}

class _CategoryHomeScreenState extends State<CategoryHomeScreen> {
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
            category.name.toLowerCase().contains(_searchText.toLowerCase()) ||
            category.keywords.any((keyword) =>
                keyword.toLowerCase().contains(_searchText.toLowerCase())))
        .toList();
  }

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
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors
                          .black, // cambiar a un color que sea visible en tu tema
                    ),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(),
                      // change color of text when user types
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      // change color of text when user types
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
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
                                  name,
                                  textAlign: TextAlign.center,
                                  //if text is too long, it will be replaced with ellipsis. only two lines
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
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
