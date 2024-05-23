import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, 'hide');
          }, icon: Icon(Icons.remove_red_eye))
        ],
      ),
      body: Column(
        children: [
          // const Text("hello"),
          // ListTile(
          //
          //    leading: CircleAvatar(),
          //   title: Text(
          //     "Hello",
          //     style: TextStyle(color: Colors.red,fontSize: 25),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: providerW!.contactList.length,
              itemBuilder: (context, index) {
                // return Text("Hello World");
                return Column(
                  children: [
                    Card.outlined(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            File('${providerR!.contactList[index].image}'),
                          ),
                        ),
                        title: Text(
                          "${providerR!.contactList[index].name}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          providerR!.selectedIndex = index;
                          Navigator.pushNamed(context, 'details',arguments: providerR!.contactList[index]);
                        },
                        
                      
                        // subtitle: Text("${providerR!.contactList[index].no}"),
                      ),
                    ),
                    // Divider()
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
