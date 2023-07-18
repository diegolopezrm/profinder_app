import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  /* List<Map<String, dynamic>> serviceCategories = [
    {'name': 'Cocina', 'icon': 'kitchen'},
    {'name': 'Plomería', 'icon': 'plumbing'},
    {'name': 'Costura', 'icon': 'sewing'},
    {'name': 'Limpieza', 'icon': 'cleaning_services'},
    {'name': 'Cuidado de niños', 'icon': 'child_care'},
    {'name': 'Enseñanza', 'icon': 'school'},
    {'name': 'Reparación de computadoras', 'icon': 'computer'},
    {'name': 'Entrenamiento físico', 'icon': 'fitness_center'},
    {'name': 'Asesoría legal', 'icon': 'gavel'},
    {'name': 'Asesoría financiera', 'icon': 'account_balance'},
    {'name': 'Fotografía', 'icon': 'camera_alt'},
    {'name': 'Mantenimiento de jardines', 'icon': 'grass'},
    {'name': 'Servicios de belleza', 'icon': 'brush'},
    {'name': 'Música y entretenimiento', 'icon': 'music_note'},
    {'name': 'Terapias y masajes', 'icon': 'spa'},
    {'name': 'Cuidado de mascotas', 'icon': 'pets'},
    {'name': 'Diseño gráfico', 'icon': 'palette'},
    {'name': 'Desarrollo de software', 'icon': 'code'},
    {'name': 'Electricista', 'icon': 'bolt'},
    {'name': 'Albañilería', 'icon': 'construction'},
    {'name': 'Carpintería', 'icon': 'handyman'},
    {'name': 'Mecánica de autos', 'icon': 'directions_car_filled'},
    {'name': 'Medicina y salud', 'icon': 'local_hospital'},
    {'name': 'Pintura y decoración', 'icon': 'format_paint'},
    {'name': 'Traducción y redacción', 'icon': 'translate'},
  ];
  */

  List<Map<String, dynamic>> serviceCategories = [
    {
      'name': 'Cocina',
      'icon': 'kitchen',
      'keywords': [
        'comida',
        'chef',
        'cocinar',
        'recetas',
        'gourmet',
        'restaurante',
        'postres',
        'pastelería',
        'sopas',
        'ensaladas'
      ]
    },
    {
      'name': 'Plomería',
      'icon': 'plumbing',
      'keywords': [
        'tuberías',
        'desagües',
        'filtraciones',
        'agua',
        'baño',
        'cocina',
        'fugas',
        'drenajes',
        'instalación',
        'reparación'
      ]
    },
    {
      'name': 'Costura',
      'icon': 'sewing',
      'keywords': [
        'ropa',
        'patrones',
        'hilos',
        'tela',
        'diseño',
        'moda',
        'máquina de coser',
        'bordado',
        'remiendos',
        'alteraciones'
      ]
    },
    {
      'name': 'Limpieza',
      'icon': 'cleaning_services',
      'keywords': [
        'orden',
        'desinfección',
        'hogar',
        'oficina',
        'productos de limpieza',
        'aspiradora',
        'limpieza profunda',
        'limpieza de ventanas',
        'limpieza de pisos',
        'limpieza de cocinas'
      ]
    },
    {
      'name': 'Cuidado de niños',
      'icon': 'child_care',
      'keywords': [
        'bebés',
        'niños',
        'juguetes',
        'educación',
        'seguridad',
        'niñera',
        'cuidador',
        'actividades',
        'juegos',
        'cuidado diurno'
      ]
    },
    {
      'name': 'Enseñanza',
      'icon': 'school',
      'keywords': [
        'educación',
        'tutor',
        'escuela',
        'estudiantes',
        'lecciones',
        'aprendizaje',
        'profesor',
        'clases',
        'asignaturas',
        'estudio'
      ]
    },
    {
      'name': 'Reparación de computadoras',
      'icon': 'computer',
      'keywords': [
        'computadora',
        'software',
        'hardware',
        'pantalla',
        'teclado',
        'memoria',
        'procesador',
        'virus',
        'tecnología',
        'datos'
      ]
    },
    {
      'name': 'Entrenamiento físico',
      'icon': 'fitness_center',
      'keywords': [
        'gimnasio',
        'ejercicio',
        'pesas',
        'aeróbico',
        'yoga',
        'entrenador',
        'fitness',
        'salud',
        'dieta',
        'rutina'
      ]
    },
    {
      'name': 'Asesoría legal',
      'icon': 'gavel',
      'keywords': [
        'abogado',
        'ley',
        'tribunales',
        'contratos',
        'derechos',
        'demandas',
        'asesoría',
        'legal',
        'regulaciones',
        'juicio'
      ]
    },
    {
      'name': 'Asesoría financiera',
      'icon': 'account_balance',
      'keywords': [
        'dinero',
        'inversiones',
        'ahorros',
        'impuestos',
        'contabilidad',
        'asesor',
        'finanzas',
        'presupuesto',
        'negocios',
        'banca'
      ]
    },
    {
      'name': 'Fotografía',
      'icon': 'camera_alt',
      'keywords': [
        'cámara',
        'fotos',
        'imágenes',
        'retrato',
        'paisaje',
        'boda',
        'eventos',
        'edición',
        'iluminación',
        'composición'
      ]
    },
    {
      'name': 'Mantenimiento de jardines',
      'icon': 'grass',
      'keywords': [
        'jardín',
        'plantas',
        'corte de césped',
        'paisajismo',
        'flores',
        'árboles',
        'herramientas de jardín',
        'riego',
        'suelo',
        'semillas'
      ]
    },
    {
      'name': 'Servicios de belleza',
      'icon': 'brush',
      'keywords': [
        'maquillaje',
        'cabello',
        'uñas',
        'facial',
        'spa',
        'peluquería',
        'estilista',
        'productos de belleza',
        'cuidado de la piel',
        'moda'
      ]
    },
    {
      'name': 'Música y entretenimiento',
      'icon': 'music_note',
      'keywords': [
        'música',
        'banda',
        'conciertos',
        'dj',
        'canto',
        'instrumentos',
        'lecciones de música',
        'entretenimiento',
        'eventos',
        'fiestas'
      ]
    },
    {
      'name': 'Terapias y masajes',
      'icon': 'spa',
      'keywords': [
        'masaje',
        'relajación',
        'spa',
        'terapia',
        'bienestar',
        'acupuntura',
        'reiki',
        'aromaterapia',
        'terapeuta',
        'salud mental'
      ]
    },
    {
      'name': 'Cuidado de mascotas',
      'icon': 'pets',
      'keywords': [
        'perros',
        'gatos',
        'mascotas',
        'alimentación',
        'paseo',
        'veterinario',
        'animales',
        'adiestramiento',
        'cuidado de mascotas',
        'jaulas'
      ]
    },
    {
      'name': 'Reparaciones de vehículos',
      'icon': 'drive_eta',
      'keywords': [
        'coches',
        'mecánico',
        'reparación',
        'motor',
        'ruedas',
        'aceite',
        'frenos',
        'transmisión',
        'batería',
        'vehículos'
      ]
    },
    {
      'name': 'Artesanías',
      'icon': 'palette',
      'keywords': [
        'arte',
        'manualidades',
        'pintura',
        'escultura',
        'joyería',
        'papel',
        'materiales de arte',
        'diseño',
        'creatividad',
        'taller'
      ]
    },
    {
      'name': 'Transporte y mudanzas',
      'icon': 'local_shipping',
      'keywords': [
        'transporte',
        'mudanzas',
        'camión',
        'embalaje',
        'carga',
        'entrega',
        'envío',
        'reubicación',
        'servicios de mudanza',
        'logística'
      ]
    },
    {
      'name': 'Construcción y remodelación',
      'icon': 'construction',
      'keywords': [
        'construcción',
        'remodelación',
        'carpintería',
        'electricidad',
        'pintura',
        'techo',
        'pisos',
        'materiales de construcción',
        'arquitectura',
        'proyecto'
      ]
    }
  ];

  Future<void> uploadServiceCategories(
      List<Map<String, dynamic>> serviceCategories) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (var category in serviceCategories) {
      final docRef = firestore.collection('serviceCategories').doc();
      batch.set(docRef, {
        'name': category['name'],
        'icon': category['icon'],
        'keywords': category['keywords'],
        'id': docRef.id,
      });
    }

    return batch.commit();
  }

  //update ServiceCategories in firebase
  Future<void> updateServiceCategories(
      List<Map<String, dynamic>> serviceCategories) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (var category in serviceCategories) {
      final docRef = firestore.collection('serviceCategories').doc();
      batch.update(docRef, {'keywords': category['keywords']});
    }

    return batch.commit();
  }

  //generate random names for testing

  String getRandomName() {
    final random = Random();
    final names = [
      'Diego',
      'Juan',
      'Pedro',
      'Maria',
      'Camila',
      'Sofia',
      'Andres',
      'Santiago',
      'Alejandro',
      'Daniel',
      'Sara',
      'Valentina',
      'Juliana',
      'Laura',
      'Luisa',
      'Ana',
      'Paula',
      'Carlos',
      'David',
      'Miguel',
      'Jose',
      'Jorge',
      'Cristian',
      'Cristina',
      'Catalina'
    ];
    return names[random.nextInt(names.length)];
  }

  //generate random last names for testing
  String getRandomLastName() {
    final random = Random();
    final lastNames = [
      'Garcia',
      'Rodriguez',
      'Martinez',
      'Hernandez',
      'Lopez',
      'Gonzalez',
      'Perez',
      'Sanchez',
      'Ramirez',
      'Torres',
      'Flores',
      'Rivera',
      'Gomez',
      'Diaz',
      'Reyes',
      'Morales',
      'Cruz',
      'Ortiz',
      'Santos',
      'Castillo',
      'Castro',
      'Vasquez',
      'Ruiz',
      'Alvarez',
      'Jimenez',
      'Moreno',
      'Romero',
      'Alvarado',
      'Fernandez',
      'Rojas',
      'Acosta',
      'Chavez',
      'Vargas',
      'Mendoza',
      'Aguilar',
      'Arias',
      'Medina',
      'Ramos',
      'Suarez',
      'Ortega',
      'Salazar',
      'Pereira',
      'Aguirre',
      'Herrera',
      'Gutierrez',
      'Valencia',
      'Guerrero',
      'Vega',
      'Varela',
      'Mora',
      'Castro',
      'Arias',
      'Giral'
    ];
    return lastNames[random.nextInt(lastNames.length)];
  }

  String getRandomPhoneNumber() {
    final random = Random();
    final phoneNumbers = [
      '3166050934',
      '3166050935',
      '3166050936',
      '3166050937',
      '3166050938',
      '3166050939',
      '3166050940',
      '3166050941',
      '3166050942',
      '3166050943',
      '3166050944',
      '3166050945',
      '3166050946',
      '3166050947',
      '3166050948',
      '3166050949',
      '3166050950',
      '3166050951',
      '3166050952',
      '3166050953',
      '3166050954',
      '3166050955',
      '3166050956',
      '3166050957',
      '3166050958',
      '3166050959',
      '3166050960',
      '3166050961',
      '3166050962',
      '3166050963',
      '3166050964',
      '3166050965',
      '3166050966',
      '3166050967',
      '3166050968',
      '3166050969',
      '3166050970',
      '3166050971',
      '3166050972',
      '3166050973',
      '3166050974',
      '3166050975',
      '3166050976',
      '3166050977',
      '3166050978',
      '3166050979',
      '3166050980',
      '3166050981',
      '3166050982',
      '3166050983',
      '3166050984',
      '3166050985',
      '3166050986',
      '3166050987',
      '3166050988',
      '3166050989',
      '3166050990',
      '3166050991',
      '3166050992',
      '3166050993',
      '3166050994',
      '3166050995',
      '3166050996',
      '3166050997',
      '3166050998',
      '3166050999',
      '3166051000',
      '3166051001',
      '3166051002',
    ];
    return phoneNumbers[random.nextInt(phoneNumbers.length)];
  }

  //get random 'limpieza', 'música', 'casa' or 'jardinería' for testing
  String getRandomMainService() {
    final random = Random();
    final mainServices = [
      'limpieza',
      'música',
      'casa',
      'jardinería',
      'aspirar',
      'cocinar',
      'cuidar niños',
      'cuidar mascotas',
    ];
    return mainServices[random.nextInt(mainServices.length)];
  }

  //get random images public urls for testing
  String getRandomImagesPublic() {
    final random = Random();
    final imagesUrl = [
      'https://libreria-servicios-integraciones.s3.amazonaws.com/60d25bdaf830ff0012d6bc84/1624398810887.jpg',
      'https://www.elespectador.com/resizer/EfCHxjuxSiIvpo79H1UCM7v3E3E=/525x350/filters:quality(60):format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/LMQG7PSYAJCBTC45WHTNAA44VE.jpg',
      'https://d2fwqvykysu662.cloudfront.net/public/NJ9iRhNcpxU9Xxcp7cbhstt0cCUK2dFexitpLxGX.jpg',
      'https://lirp.cdn-website.com/a8fb6303/dms3rep/multi/opt/personal-de-limpieza-1920w.jpg',
      'https://papelrod.com/wp-content/uploads/2023/05/Aseo.jpg',
      'https://mundodotaciones.com/wp-content/uploads/2021/09/file.png',
      'https://novaseo.com.co/wp-content/uploads/2019/08/productos-de-aseo-4.jpg',
    ];

    return imagesUrl[random.nextInt(imagesUrl.length)];
  }

  //upload random users prestador data to firebase to test the app with real data
  /* address: "dcccc"
birthday: 20 de agosto de 2002, 00:00:00 UTC-5
interests
lastConnection: 18 de julio de 2023, 00:42:03 UTC-5
lastName: "lopez"
mainService: "DwgzzUf9J2kDObfOypiG"
name:"diego"
onboarding:true
phoneNumber:"3166050934"
role:"prestador"
service: {categories
0
"ffff"
1
"fffff"
2
"fffff"
3
"ffff"
4
"ffff"
description
"fffffff"
images
} */
  Future<void> uploadRandomUsersPrestadorData() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (var i = 0; i < 100; i++) {
      final docRef = firestore.collection('users').doc();
      batch.set(docRef, {
        'address': 'Carrrera 1 # 1 - 1',
        'birthday':
            DateTime.now().subtract(Duration(days: Random().nextInt(10000))),
        'interests': [],
        'lastConnection': DateTime.now(),
        'lastName': getRandomLastName(),
        'mainService': 'tLVO5LGhnPIAdj2zck5z',
        'name': getRandomName(),
        'onboarding': true,
        'phoneNumber': getRandomPhoneNumber(),
        'role': 'prestador',
        'service': {
          'categories': [
            getRandomMainService(),
            getRandomMainService(),
            getRandomMainService(),
          ],
          'description':
              'Hago aseo en casas y apartamentos, soy muy bueno, me gusta hacerlo y lo hago bien',
          'images': [
            getRandomImagesPublic(),
            getRandomImagesPublic(),
            getRandomImagesPublic(),
          ],
        },
      });
    }

    return batch.commit();
  }

  //delete all user with Campo
/* lastConnection
=
Tipo
timestamp
Fecha
18 jul 2023 Hora 08:58:52
 */

  Future<void> deleteAllUsersWithCampo() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    final querySnapshot = await firestore
        .collection('users')
        .where('lastConnection',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(2023, 7, 18, 8, 58, 52)))
        .get();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    //listview of buttons
    return ListView(
      children: [
        //button 1
        ElevatedButton(
          onPressed: () {
            uploadServiceCategories(serviceCategories);
          },
          child: Text('Button 1'),
        ),
        //button 2
        ElevatedButton(
          onPressed: () {
            uploadRandomUsersPrestadorData();
          },
          child: Text('Button 2'),
        ),
        //button 3
        ElevatedButton(
          onPressed: () {
            deleteAllUsersWithCampo();
          },
          child: Text('Button 3'),
        ),
      ],
    );
  }
}
