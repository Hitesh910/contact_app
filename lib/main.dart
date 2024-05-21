import 'package:contact_app2/screen/contact/provider/contact_provider.dart';
import 'package:contact_app2/screen/home/provider/home_provider.dart';
import 'package:contact_app2/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ContactProvider(),),
        ChangeNotifierProvider.value(value: HomeProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blue.shade400,
          ),
        ),
        routes: app_route,
      ),
    ),
  );
}
