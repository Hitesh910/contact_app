import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier
{
  String? selectedImagePath;
  int stepContact = 0;

  void changeImage(String? path)
  {
    selectedImagePath = path;
    notifyListeners();
  }

  void nextStep()
  {
    if(stepContact < 5)
    {
      stepContact ++;
    }
    notifyListeners();
    //stepIndex++;
  }

  void CancelStep()
  {
    if(stepContact > 0)
      {
        stepContact --;
      }
    notifyListeners();
  }
}
