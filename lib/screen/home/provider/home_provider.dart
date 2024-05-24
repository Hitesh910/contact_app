import 'package:flutter/material.dart';

import '../../contact/model/contact_model.dart';

class HomeProvider with ChangeNotifier
{
  int selectedIndex = 0;
  List<ContactModel> contactList = [];
  List<ContactModel> hideList = [];
  bool? isCheck;


  void addData(ContactModel contact)
  {
    contactList.add(contact);
    notifyListeners();
  }

  void updateindex(int i) {
    i = selectedIndex;
    notifyListeners();
  }

  void updateData(ContactModel c1)
  {
    contactList[selectedIndex] = c1;
    notifyListeners();
  }

  void deleteContact() {
    contactList.removeAt(selectedIndex);
    notifyListeners();
  }

  void hideData(ContactModel c1) {
    hideList.add(c1);
    deleteContact();
    notifyListeners();
  }

  void deleteHideContact() {
    hideList.removeAt(selectedIndex);
    notifyListeners();
  }

  void isHide(bool check) {
    check = isCheck!;
    notifyListeners();
  }

  void unhideData(ContactModel c1)
  {
    contactList.add(c1);
    deleteHideContact();
    notifyListeners();
  }
}