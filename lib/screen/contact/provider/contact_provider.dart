import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier
{
  String? selectedImagePath;

  void changeImage(String? path)
  {
    selectedImagePath = path;
    notifyListeners();
  }
}