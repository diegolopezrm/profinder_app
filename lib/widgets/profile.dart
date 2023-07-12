import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  
  //DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
  //final user = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get()
  
  //final name = FirebaseAuth.instance.currentUser!.displayName ?? "name is null";
  //final email = FirebaseAuth.instance.currentUser!.email ?? "email is null";
  //final phone = FirebaseAuth.instance.currentUser!.phoneNumber ?? "phone number is null";
  
  @override
  Widget build(BuildContext context) {

    Future<String> userData() async{

    var data = await FirebaseFirestore.instance.collection('Collection_name').doc('Document_Id').get();
    String name = data['name']
    return name;
}

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 36, 98, 38),
          title: const Center(
            child: Text('Perfil'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(          //La caja verde donde esta la imagen de perfil y el nombre
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient( //gradiente
                  colors: [Colors.green, Colors.green.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.3, 0.8],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row( //Este Row es mas que todo para posicionar la foto perfil en el centro, pero imagino que se podria hacer de otra forma
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), //esto es para que todo no quede tan pegado
                  Text(
                    userData(),
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Nombre de empresa/local/negocio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Text(
                    'Informacion de contacto:',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      email,
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
                      phone,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text(
                      'Linkedin',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'www.linkedin.com/in/nombre-apellido-12345678',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Servicios ofrecidos',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    title: Text(
                      'Revision a domicilio',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Inspección de automóviles para determinar daños o fallas y estimar los costos de reparación',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  const ListTile(
                    title: Text(
                      'Mantenimiento preventivo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Revisión de los  automóviles para asegurarse que estén en perfectas condiciones',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  const ListTile(
                    title: Text(
                      'Venta de repuestos y reparaciones varias',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Desembolladura, pintura, repuestos, aceites, etc',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Imagenes relevantes',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      );

  }
}