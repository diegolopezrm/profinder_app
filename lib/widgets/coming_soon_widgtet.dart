import 'package:flutter/material.dart';
import 'package:profinder_app/utils/my_colors.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  _ComingSoonScreenState createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Próxima funcionalidad'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.construction,
              size: 100,
              color: MyColors.primary,
            ),
            const SizedBox(height: 20),
            const Text(
              'Próximamente',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MyColors.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Esta funcionalidad está en desarrollo.\n¡Vuelve pronto!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
