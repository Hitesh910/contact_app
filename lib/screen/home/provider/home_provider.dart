import 'package:flutter/material.dart';

import '../../contact/model/contact_model.dart';

class HomeProvider with ChangeNotifier
{
  int selectedIndex = 0;
  List<ContactModel> contactList = [];


  void addData(ContactModel contact)
  {
    contactList.add(contact);
    notifyListeners();
  }
}