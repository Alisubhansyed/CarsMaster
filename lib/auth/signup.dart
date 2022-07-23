import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool signstate = false;
  final TextEditingController? passwordsup = TextEditingController();
  final TextEditingController? emailsup = TextEditingController();
  final TextEditingController? namesup = TextEditingController();
  PlatformFile? pickedfile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 4, 233),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          const SizedBox(
                            height: 170,
                          ),
                          ClipOval(
                            child: Container(
                              color: Color.fromARGB(255, 218, 217, 216),
                              height: 150,
                              width: 150,
                              child: Center(
                                  child: pickedfile == null
                                      ? Icon(
                                          Icons.person,
                                          size: 120,
                                        )
                                      : Image.file(
                                          File(pickedfile!.path.toString()))),
                            ),
                          ),
                          // const CircleAvatar(
                          //   backgroundImage: AssetImage("asset/tesla.png"),
                          //   radius: 75,
                          // ),
                          Positioned(
                              top: 100,
                              right: 3,
                              child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles();
                                    if (result == null) {
                                      return;
                                    }
                                    setState(() {
                                      pickedfile = result.files.first;
                                    });
                                  }))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 27.5),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Are you Driver?",
                          style: TextStyle(color: Colors.white, fontSize: 20.5),
                        ),
                        CupertinoSwitch(
                            trackColor:
                                const Color.fromARGB(255, 238, 242, 255),
                            thumbColor: Colors.white,
                            activeColor:
                                const Color.fromARGB(255, 233, 235, 236),
                            value: signstate,
                            onChanged: (val) {
                              setState(() {});
                              signstate = val;
                            })
                      ],
                    ),
                    TextFormField(
                      controller: namesup,
                      style: const TextStyle(
                          fontSize: 20, color: Colors.white, letterSpacing: 2),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        labelStyle:
                            TextStyle(fontSize: 23, color: Colors.white),
                        floatingLabelStyle:
                            TextStyle(fontSize: 25, color: Colors.white),
                        labelText: "Name",
                        fillColor: Colors.white,

                        // isDense: true,
                      ),
                    ),
                    TextFormField(
                      controller: emailsup,
                      style: const TextStyle(
                          fontSize: 20, color: Colors.white, letterSpacing: 2),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        labelStyle:
                            TextStyle(fontSize: 23, color: Colors.white),
                        floatingLabelStyle:
                            TextStyle(fontSize: 25, color: Colors.white),
                        labelText: "Email Address",
                        fillColor: Colors.white,

                        // isDense: true,
                      ),
                    ),
                    TextFormField(
                      controller: passwordsup,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        labelStyle:
                            TextStyle(fontSize: 23, color: Colors.white),
                        floatingLabelStyle:
                            TextStyle(fontSize: 25, color: Colors.white),
                        labelText: "password",
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),

                        // isDense: true,
                      ),
                      obscureText: true,
                      obscuringCharacter: '*',
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 118, 223, 105),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        try {
                          UserCredential result = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailsup!.text.trim(),
                                  password: passwordsup!.text.trim());
                          result.user!.updateDisplayName(namesup!.text.trim());
                          await FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          if (FirebaseAuth.instance.currentUser != null) {
                            final path =
                                "${FirebaseAuth.instance.currentUser!.email}}";
                            final file = File(pickedfile!.path.toString());
                            final ref =
                                FirebaseStorage.instance.ref().child(path);
                            ref.putFile(file);
                          }
                        } on FirebaseAuthException catch (e) {
                          print("$e" +
                              "errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                        }
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Do have an accunt?",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  MaterialButton(
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Signin",
                        style: TextStyle(
                            color: Color.fromARGB(255, 49, 90, 214),
                            fontSize: 18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const loginScreen(),
                          ));
                    },
                    color: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color.fromARGB(255, 36, 89, 170),
              ),
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
