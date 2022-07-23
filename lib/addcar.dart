import 'dart:io';
import 'package:app1/croper.dart';
import 'package:app1/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';

class Addcar extends StatefulWidget {
  const Addcar({Key? key}) : super(key: key);

  @override
  State<Addcar> createState() => _AddcarState();
}

class _AddcarState extends State<Addcar> {
  Future filePicer() async {}
  // CroppedFile? pickedfile;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discription = TextEditingController();
  PlatformFile? pickedfile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: const Text(
              "Add New Car",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) {
                        return;
                      } else {
                        // CroppedFile? croppedFile =
                        //     await ImageCropper().cropImage(
                        //   sourcePath: result.files.first.path!,
                        //   aspectRatioPresets: [
                        //     CropAspectRatioPreset.square,
                        //   ],
                        //   uiSettings: [
                        //     AndroidUiSettings(
                        //         activeControlsWidgetColor:
                        //             Color.fromARGB(255, 187, 185, 185),
                        //         toolbarTitle: 'Cropper',
                        //         toolbarColor: Colors.black,
                        //         toolbarWidgetColor: Colors.white,
                        //         initAspectRatio: CropAspectRatioPreset.original,
                        //         lockAspectRatio: true),
                        //     IOSUiSettings(
                        //       title: 'Cropper',
                        //     ),
                        //   ],
                        // );
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) {
                          return;
                        }
                        setState(() {
                          pickedfile = result.files.first;
                        });
                        // if (croppedFile != null) {
                        //   setState(() {
                        //     filePicked = result.files.first.path;
                        //     pickedfile = croppedFile;
                        //   });
                        // }
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 36, 33, 33),
                        ),
                        height: 200,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add images",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: title,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 1),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                          labelStyle:
                              TextStyle(fontSize: 23, color: Colors.black),
                          floatingLabelStyle:
                              TextStyle(fontSize: 25, color: Colors.black),

                          // isDense: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListTile(
                    shape: OutlineInputBorder(),
                    title: Text("Brand"),
                    subtitle: Text("any"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: price,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 1),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                          labelStyle:
                              TextStyle(fontSize: 23, color: Colors.black),
                          floatingLabelStyle:
                              TextStyle(fontSize: 25, color: Colors.black),

                          // isDense: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Discription",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: discription,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 1),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                          labelStyle:
                              TextStyle(fontSize: 23, color: Colors.black),
                          floatingLabelStyle:
                              TextStyle(fontSize: 25, color: Colors.black),

                          // isDense: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListTile(
                    shape: OutlineInputBorder(),
                    title: Text("Location"),
                    subtitle: Text("Choose"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color.fromARGB(255, 8, 4, 233),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      final path =
                          "${FirebaseAuth.instance.currentUser!.uid}/${pickedfile!.name}}";
                      final file = File(pickedfile!.path.toString());
                      final ref = FirebaseStorage.instance.ref().child(path);
                      ref.putFile(file);
                      ref.getDownloadURL().then((value) async {
                        FirebaseFirestore.instance.collection("item").add({
                          "title": title.value.text,
                          "price": price.value.text,
                          "decription": discription.value.text,
                          "imageurl": await ref.getDownloadURL(),
                          "useremail": FirebaseAuth.instance.currentUser!.email,
                          "date": DateTime.now(),
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const App(),
                            ));
                      });
                    },
                    child: const Text(
                      "Add Car",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
