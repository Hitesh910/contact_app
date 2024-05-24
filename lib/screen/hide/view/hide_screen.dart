import 'dart:io';

import 'package:contact_app2/screen/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HideScreen extends StatefulWidget {
  const HideScreen({super.key});

  @override
  State<HideScreen> createState() => _HideScreenState();
}

class _HideScreenState extends State<HideScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
  providerR = context.read<HomeProvider>();
  providerW = context.watch<HomeProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Hidden Screen"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: providerW!.hideList!.length,
                itemBuilder: (context, index) {
                  // return Text("Hello World");
                  return Column(
                    children: [
                      Card.outlined(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              File('${providerR!.hideList[index].image}'),
                            ),
                          ),
                          title: Text(
                            "${providerR!.hideList[index].name}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            print(providerR!.hideList[index].no);
                            providerR!.selectedIndex = index;
                            Navigator.pushNamed(context, 'details',
                                arguments: providerR!.hideList[index]);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
