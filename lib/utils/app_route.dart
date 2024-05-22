import 'package:contact_app2/screen/contact/view/contact_screen.dart';
import 'package:contact_app2/screen/details/view/details_screen.dart';
import 'package:contact_app2/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_route = {
  "/":(context)=> const HomeScreen(),
  "contact":(context)=> const ContactScreen(),
  "details":(context)=> DetailsScreen(),
};