import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:profinder_app/models/category.dart';
import 'package:profinder_app/utils/my_colors.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../widgets/profile_card.dart';
import '../profile_prestador/profile_prestador_config_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  final Category category;

  const CategorySelectionScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final List<Widget> profiles = [];

  final SwipableStackController _controller = SwipableStackController();

  // get all users in firestore with the role "prestador" and return the list of ProfileCard
  Future<List<Widget>> getProfiles() async {
    List<Widget> profiles = [];

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'prestador')
        .where('mainService', isEqualTo: widget.category.id)
        .get();

    int index = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data();
      profiles.add(ProfileCard(
          index: index,
          categories: data['service']['categories'].cast<String>(),
          description: data['service']['description'],
          imageUrl: data['service']['images']));
      index++;
    }

    return profiles;
  }

  @override
  void initState() {
    super.initState();
    getProfiles().then((value) {
      setState(() {
        profiles.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightGreen,
      body: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: MyColors.primary),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Seleccione su perfil indicado',
              style: TextStyle(color: MyColors.primary),
            ),
          ),
          profiles.isEmpty
              ? const Center(
                  child: Text('No hay perfiles disponibles',
                      style: TextStyle(color: MyColors.primary)))
              : SwipableStack(
                  controller: _controller,
                  itemCount: profiles.length,
                  onSwipeCompleted: (index, direction) {
                    if (direction == SwipeDirection.left) {
                      print('Dislike');
                    } else {
                      print('Like');
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfilePrestadorConfigScreen(

                              ), // Navega a la pantalla ProfilePrestadorConfigScreen
                        ),
                      ); */
                    }
                  },
                  builder: (context, properties) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox.fromSize(
                        size: Size.fromHeight(
                            MediaQuery.of(context).size.height * 0.7),
                        child: Stack(
                          children: [
                            profiles[properties.index],
                            Positioned(
                              right: 16.0,
                              top: 16.0,
                              child: Opacity(
                                opacity: (properties.swipeProgress > 0.1
                                        ? properties.swipeProgress
                                        : 0)
                                    .toDouble()
                                    .clamp(0.0, 1.0),
                                child: const RotatedBox(
                                  quarterTurns: 1,
                                  child: Text('LIKE',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          profiles.isEmpty
              ? const SizedBox()
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: () => _controller.next(
                                swipeDirection: SwipeDirection.left),
                            child: const Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: () => _controller.next(
                                swipeDirection: SwipeDirection.right),
                            child: const Icon(Icons.favorite),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
