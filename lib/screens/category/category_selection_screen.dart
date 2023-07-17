import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:profinder_app/models/category.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CategorySelectionScreen extends StatefulWidget {
  final Category category;

  const CategorySelectionScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}


class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  // Reemplaza esto con tu lista real de perfiles
  final List<Widget> profiles =
      List.generate(10, (index) => ProfileCard(index: index));

  final SwipableStackController _controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipableStack(
        controller: _controller,
        itemCount: profiles.length,
        onSwipeCompleted: (index, direction) {
          if (direction == SwipeDirection.left) {
            print('Dislike');
          } else {
            print('Like');
          }
        },
        builder: (context, properties) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox.fromSize(
              size: Size.fromHeight(MediaQuery.of(context).size.height * 0.7),
              child: profiles[properties.index],
            ),
          );
        },
      ),
    );
  }
}

// Un widget simple para representar el perfil, reemplázalo con tu implementación real
class ProfileCard extends StatelessWidget {
  final int index;

  ProfileCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text('Profile $index'),
      ),
    );
  }
}
