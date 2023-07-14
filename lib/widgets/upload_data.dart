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
        'keywords': category['keywords']
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
            //do something
          },
          child: Text('Button 2'),
        ),
        //button 3
        ElevatedButton(
          onPressed: () {
            //do something
          },
          child: Text('Button 3'),
        ),
      ],
    );
  }
}
