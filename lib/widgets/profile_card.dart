import 'package:flutter/material.dart';
import 'package:profinder_app/utils/my_colors.dart';

class ProfileCard extends StatefulWidget {
  final int index;
  final List imageUrl; // reemplaza por tu imagen de perfil real
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
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.imageUrl);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                color: MyColors.primary,
                child: Column(
                  children: <Widget>[
                    //list of images in a vertical
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        itemCount: widget.imageUrl.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
                              const Text('Descripción',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.lightGreen)),
                              Text(widget.description,
                                  style: const TextStyle(
                                      fontSize: 12, color: MyColors.secondary)),
                              const Text('Categorías:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.lightGreen)),
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                children: widget.categories
                                    .map((category) => Chip(
                                          backgroundColor: MyColors.secondary,
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
                    widget.imageUrl.isEmpty
                        ? Image.network(
                            "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity)
                        : Image.network(
                            widget.imageUrl[0],
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
                        widget.description,
                        style: const TextStyle(
                            fontSize: 12, color: MyColors.secondary),
                      ),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: widget.categories
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
