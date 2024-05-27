import 'dart:io';
import 'package:contact_app2/screen/contact/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';
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
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNo = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  int stepIndex =0;

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
          padding:  EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Stepper(
              currentStep: stepIndex,
              onStepContinue: () {
                // if(providerW?.stepContact==0)
                //   {
                    if(providerW!.selectedImagePath!.isNotEmpty)
                      {
                        if(stepIndex <= 3)
                        {
                          stepIndex += 1;
                        }
                        // providerR?.nextStep();
                      }
                  // }
                  // if(stepIndex<0)
                  // {
                  //   stepIndex += 1;
                  // }
                  //stepIndex++;
              },
              onStepCancel: () {
                if(stepIndex > 0)
                  {
                    stepIndex -= 1;
                  }
              },
              onStepTapped: (int index) {
                stepIndex = index ;
              },
              steps: [
                Step(
                    title: Text("Contact photo"),
                    content: Column(
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
                            XFile? xFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            providerR?.changeImage(xFile!.path);
                          },
                          icon: const Icon(Icons.camera_alt),
                        ),
                      ],
                    )),
                Step(
                  title: Text("Contact name"),
                  content: TextFormField(
                    controller: txtName,
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
                ),
                Step(
                  title: Text("Contact no"),
                  content: TextFormField(
                    controller: txtNo,
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
                ),
                Step(
                  title: Text("Contact email"),
                  content: TextFormField(
                    controller: txtEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Invalid Email";
                        }
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Column(
// children: [
//
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// controller: txtName,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// label: Text("Name"),
// ),
// validator: (value) {
// if (value!.isEmpty) {
// return "Name is required";
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// controller: txtNo,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// label: Text("Mobile"),
// ),
// validator: (value) {
// if (value!.isEmpty) {
// return "Mobile is required";
// } else if (value.length != 10) {
// return "Invalid mobile";
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// TextFormField(
// controller: txtEmail,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// label: Text("Email"),
// ),
// validator: (value) {
// if (value!.isNotEmpty) {
// if (!RegExp(
// r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//     .hasMatch(value)) {
// return "Invalid Email";
// }
// }
// return null;
// },
// ),
// const SizedBox(
// height: 10,
// ),
// ElevatedButton(
// onPressed: () {
// if (formKey.currentState!.validate()) {
//
// ContactModel c1 = ContactModel(
// image: providerR!.selectedImagePath,
// email: txtEmail.text,
// name: txtName.text,
// no: txtNo.text);
//
// context.read<HomeProvider>().addData(c1);
// Navigator.pop(context);
// providerR?.changeImage(null);
//
// }
// },
// child: const Text("Save"),
// )
// ],
// ),
//
