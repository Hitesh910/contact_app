import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier
{
  String? selectedImagePath;
  int stepContact =0;

  void changeImage(String? path)
  {
    selectedImagePath = path;
    notifyListeners();
  }

  void nextStep()
  {
    if(stepContact != 2)
    {
      stepContact += 1;
    }
    notifyListeners();
    //stepIndex++;
  }
}