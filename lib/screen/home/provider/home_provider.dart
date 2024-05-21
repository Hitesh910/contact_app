import 'package:flutter/material.dart';

import '../../contact/model/contact_model.dart';

class HomeProvider with ChangeNotifier
{
  List<ContactModel> contactList = [];

  void addData(ContactModel contact)
  {
    contactList.add(contact);
    notifyListeners();
  }
}