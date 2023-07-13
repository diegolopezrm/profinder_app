// create a model class to firebase data
//{'name': 'Cocina', 'icon': 'kitchen'},

import 'package:flutter/material.dart';

class Category {
  final String name;
  final String icon;
  final List keywords = [];

  Map<String, IconData> iconMapping = {
    'kitchen': Icons.kitchen,
    'plumbing': Icons.plumbing,
    'sewing': Icons.chair,
    'cleaning_services': Icons.cleaning_services,
    'child_care': Icons.child_care,
    'school': Icons.school,
    'computer': Icons.computer,
    'fitness_center': Icons.fitness_center,
    'gavel': Icons.gavel,
    'local_shipping': Icons.local_shipping,
    'drive_eta': Icons.drive_eta,
    'account_balance': Icons.account_balance,
    'camera_alt': Icons.camera_alt,
    'grass': Icons.grass,
    'brush': Icons.brush,
    'music_note': Icons.music_note,
    'spa': Icons.spa,
    'pets': Icons.pets,
    'palette': Icons.palette,
    'code': Icons.code,
    'bolt': Icons.bolt,
    'construction': Icons.construction,
    'handyman': Icons.handyman,
    'directions_car_filled': Icons.directions_car_filled,
    'local_hospital': Icons.local_hospital,
    'format_paint': Icons.format_paint,
    'translate': Icons.translate,
  };

  Category({required this.name, required this.icon, List? keywords}) {
    if (keywords != null) {
      this.keywords.addAll(keywords);
    }
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], icon: json['icon'], keywords: json['keywords']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'keywords': keywords,
      };

  Icon getIcon() {
    return Icon(iconMapping[icon]);
  }
}
