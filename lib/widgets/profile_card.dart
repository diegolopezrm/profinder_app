import 'package:flutter/material.dart';
import 'package:profinder_app/utils/my_colors.dart';

class ProfileCard extends StatelessWidget {
  final int index;
  final String imageUrl; // reemplaza por tu imagen de perfil real
  final String description; // reemplaza por tu descripción real
  final List<String> categories; // reemplaza por tu lista de categorías reales

  const ProfileCard({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.description,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                color: MyColors.primary,
                child: ListView(
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: //image network with placeholder
                            Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Descripción del perfil $index',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(description),
                              const Text(
                                'Categorías:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                children: categories
                                    .map((category) => Chip(
                                          label: Text(category),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        color: MyColors.primary,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 7,
                child: //image network with placeholder
                    Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        description,
                        style: const TextStyle(
                            fontSize: 12, color: MyColors.secondary),
                      ),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: categories
                            .map((category) => Chip(
                                  label: Text(category),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
