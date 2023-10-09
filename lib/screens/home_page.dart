// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/screens/widget_page.dart';
import 'package:flutter_proj/utils/colors.dart';
import 'package:flutter_proj/utils/functons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_proj/utils/snackbar.dart';

import '../services/firebase_storage_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static ValueNotifier<bool> text = ValueNotifier<bool>(false);
  static ValueNotifier<bool> img = ValueNotifier<bool>(false);
  static ValueNotifier<bool> btn = ValueNotifier<bool>(false);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference ref = FirebaseFirestore.instance.collection("data");
  TextEditingController textController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool showError = false;
  List<File> mediaFiles = [];

  void onPickImages() async {
    mediaFiles = [];
    List<File> files = await pickMediaFile();

    for (var file in files) {
      mediaFiles.add(file);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Assignment App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: size.width * .8,
                  height: size.height * .75,
                  decoration: BoxDecoration(color: Colors.green.shade100),
                  child: Column(
                    children: [
                      Spacer(),
                      ValueListenableBuilder(
                        valueListenable: Home.text,
                        builder: (context, value, child) {
                          return value
                              ? SizedBox(
                                  width: size.width * .7,
                                  child: TextFormField(
                                    validator: ((value) {
                                      if (value!.isEmpty) {
                                        return "Enter Text";
                                      }
                                      return null;
                                    }),
                                    controller: textController,
                                    decoration: InputDecoration(
                                        hintText: "Enter text",
                                        fillColor: Colors.grey,
                                        filled: true),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                );
                        },
                      ),
                      Spacer(),
                      if (showError) Text("Add atleast a widget to save"),
                      ValueListenableBuilder(
                        valueListenable: Home.img,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return value
                              ? Container(
                                  height: size.height * .3,
                                  width: size.width * .6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      image: mediaFiles.isNotEmpty
                                          ? DecorationImage(
                                              image: FileImage(mediaFiles[0]))
                                          : null),
                                  child: mediaFiles.isEmpty
                                      ? TextButton(
                                          onPressed: () async {
                                            onPickImages();
                                          },
                                          child: Text("Upload Image"))
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                )
                              : SizedBox(
                                  width: 0,
                                  height: 0,
                                );
                        },
                      ),
                      Spacer(),
                      ValueListenableBuilder(
                        valueListenable: Home.btn,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return value
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(baseColor)),
                                  onPressed: () async {
                                    print(mediaFiles);
                                    if (!Home.img.value && !Home.text.value) {
                                      setState(() {
                                        showError = true;
                                      });
                                    } else if (_formkey.currentState!
                                            .validate() &&
                                        mediaFiles.isNotEmpty) {
                                      showSnackbar(context, "Uploading");
                                      final fileUrl =
                                          await FirebaseStorageService()
                                              .uploadFileToFirebaseStorage(
                                                  mediaFiles[0].path);
                                      if (fileUrl!.isNotEmpty) {
                                        ref.doc("docref").set({
                                          "text": textController.text,
                                          "imgUrl": fileUrl
                                        }).then((value) {
                                          showSnackbar(
                                              context, "Successfully saved");
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                );
                        },
                      ),
                      Spacer()
                    ],
                  )),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(baseColor)),
                onPressed: () {
                  setState(() {
                    showError = false;
                    mediaFiles = [];
                    textController.text = "";
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => WidgetPage())));
                },
                child: Text(
                  "Add Widget",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
