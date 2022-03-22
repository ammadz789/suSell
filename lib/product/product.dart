import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product {

  String name = '';
  String description = '';
  int price = 0;
  String comment = '';

  Product({required this.name, required this.description, required this.price});
}
class image {
  String image_name = '';

  void setImageName(String name) {
    image_name = name;
  }

  String getImageName() {
    return image_name;
  }
}
