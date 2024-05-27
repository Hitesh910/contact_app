import 'dart:io';

import 'package:contact_app2/screen/contact/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/provider/home_provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ContactModel? model;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNo = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // int? index;
    model = ModalRoute.of(context)!.settings.arguments as ContactModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact info"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("Edit"),
                  onTap: () {
                    update();
                  },
                ),
                PopupMenuItem(
                  child: const Text("Delete"),
                  onTap: () {
                    context.read<HomeProvider>().isHide == true
                        ? context.read<HomeProvider>().deleteContact()
                        : context.read<HomeProvider>().deleteHideContact();
                    Navigator.pop(context);
                  },
                ),
                PopupMenuItem(
                  child: context.read<HomeProvider>().isCheck! ?Text("hide"):Text("Unhide"),
                  onTap: () {
                    // context.read<HomeProvider>().deleteContact();
                    context.read<HomeProvider>().hideData(model!);
                    Navigator.pop(context);
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              File("${model!.image}"),
              width: MediaQuery.sizeOf(context).width,
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text("${model!.name}"),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: const Text(
                  "Mobile",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text("${model!.no}"),
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () async {
                    await launch("tel: +91 ${model!.no}");
                    // final Uri call = Uri(scheme: 'tel',path: '+91111111');
                    // if(await canLaunchUrl(call))
                    //   {
                    //     await launchUrl(call);
                    //   }
                    // else
                    //   {
                    //     // throw 'Could not launch $call';
                    //     print('can not launch url');
                    //   }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text("${model!.no}"),
              trailing: const Icon(Icons.message),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text("${model!.email}"),
              trailing: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }

  void update() {
    txtName.text = model!.name!;
    txtNo.text = model!.no!;
    txtEmail.text = model!.email!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File("${model!.image}")),
                  ),
                  IconButton.filledTonal(
                      onPressed: () {}, icon: const Icon(Icons.camera_alt)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtNo,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Mobile"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mobile is required";
                      } else if (value.length != 10) {
                        return "Invalid Mobile no";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtEmail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (value!.isNotEmpty) {
                        if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Invalid Email";
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ContactModel c1 = ContactModel(
                              no: txtNo.text,
                              name: txtName.text,
                              email: txtEmail.text,
                              image: model!.image);

                          context.read<HomeProvider>().updateData(c1);
                          print(c1.name);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Submit"))
                ],
              ),

            ),
          ),
        );
      },
    );
  }
}

