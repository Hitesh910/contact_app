import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ContactProvider? providerR;
  ContactProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                (providerW!.selectedImagePath == null)
                    ? const CircleAvatar(
                        radius: 60,
                      )
                    : CircleAvatar(
                        radius: 50,
                        // backgroundImage: FileImage(File(providerW!.selectedImagePath)),
                        backgroundImage: FileImage(
                          File(providerW!.selectedImagePath!),
                        ),
                      ),
                IconButton.filledTonal(
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? xFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    providerR?.changeImage(xFile!.path);
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                  ),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Mobile"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile is required";
                    } else if (value.length != 10) {
                      return "Invalid mobile";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                  ),
                  validator: (value) {
                    if(value!.isNotEmpty)
                      {
                        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
                        {
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
                        Navigator.pop(context);
                        providerR?.changeImage(null);
                      }
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
