import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool signstate = false;
  bool theme = false;
  Future<String> pimage() async {
    final path = "${FirebaseAuth.instance.currentUser!.email}}";

    final ref = FirebaseStorage.instance.ref().child(path);
    print("${ref.getDownloadURL().toString()}" +
        "ssddddddddddddddddddddddddddddddddd");
    return ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    double heightM = MediaQuery.of(context).size.height;
    double widthM = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: heightM / 1.2,
            margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 170,
                      ),
                      FutureBuilder<String>(
                        future: pimage(),
                        builder: (context, snapshot) {
                          return (snapshot.hasData)
                              ? CircleAvatar(
                                  child:
                                      Image.network(snapshot.data.toString()),
                                  radius: 75,
                                )
                              : CircularProgressIndicator();
                        },
                      ),
                      Positioned(
                          top: 100,
                          right: 3,
                          child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              onPressed: () {}))
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  trailing: Text(
                    "${FirebaseAuth.instance.currentUser!.displayName}",
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  trailing: Text(
                    "${FirebaseAuth.instance.currentUser!.email}",
                  ),
                ),
                ListTile(
                  leading: Text(
                    "Are you Driver?",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  trailing: Switch(
                      activeTrackColor: Colors.green,
                      activeColor: const Color.fromARGB(255, 233, 235, 236),
                      value: signstate,
                      onChanged: (val) {
                        setState(() {});
                        signstate = val;
                      }),
                ),
                ListTile(
                  leading: Icon(Icons.sunny),
                  trailing: Switch(
                      activeTrackColor: Colors.green,
                      activeColor: const Color.fromARGB(255, 233, 235, 236),
                      value: theme,
                      onChanged: (val) {
                        setState(() {});
                        theme = val;
                      }),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color.fromARGB(255, 8, 4, 233),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    "logout",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
