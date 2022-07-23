// ignore_for_file: camel_case_types

import 'package:app1/addcar.dart';
import 'package:app1/chat.dart';
import 'package:app1/notify.dart';
// import 'package:app1/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'auth/signup.dart';
import 'home.dart';
import 'modules/authChecker.dart';
import 'profile.dart';
import 'providerutility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,
  //     overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Colored(),
      child: const MaterialApp(
        home: AuthChecker(),
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Navigtor();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return snapshot.hasData ? Navigtor() : Signup();
      },
    );
  }
}

class Navigtor extends StatefulWidget {
  const Navigtor({Key? key}) : super(key: key);

  @override
  State<Navigtor> createState() => _NavigtorState();
}

class _NavigtorState extends State<Navigtor> {
  int _selected = 0;
  List Screen = [App(), Chat(), Addcar(), FileUploadPage(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[_selected],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 14, 13, 13),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_sharp), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: "chat"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add), label: "add"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell), label: "notify"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: "profile"),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: const Color.fromARGB(255, 139, 136, 136),
          selectedItemColor: Colors.white,
          elevation: 2,
          currentIndex: _selected,
          type: BottomNavigationBarType.fixed,
          onTap: (int select) {
            setState(() {
              _selected = select;
            });
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => Screen[_selected],
            //     ));
          },
        ),
      ),
    );
  }
}

// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   bool signstate = false;
//   final TextEditingController? passwordsup = TextEditingController();
//   final TextEditingController? emailsup = TextEditingController();
//   final TextEditingController? namesup = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 49, 90, 214),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Center(
//                       child: Stack(
//                         children: [
//                           SizedBox(
//                             height: 170,
//                           ),
//                           CircleAvatar(
//                             backgroundImage: AssetImage("asset/tesla.png"),
//                             radius: 75,
//                           ),
//                           Positioned(
//                               top: 100,
//                               right: 3,
//                               child: FloatingActionButton(
//                                   backgroundColor: Colors.white,
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {}))
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 200,
//                       child: const Text(
//                         "Signup", 
//                         style: TextStyle(color: Colors.white, fontSize: 27.5),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Are you Driver?",
//                           style: TextStyle(color: Colors.white, fontSize: 20.5),
//                         ),
//                         CupertinoSwitch(
//                             trackColor:
//                                 const Color.fromARGB(255, 238, 242, 255),
//                             thumbColor: Colors.white,
//                             activeColor:
//                                 const Color.fromARGB(255, 233, 235, 236),
//                             value: signstate,
//                             onChanged: (val) {
//                               setState(() {});
//                               signstate = val;
//                             })
//                       ],
//                     ),
//                     TextFormField(
//                       controller: namesup,
//                       style: TextStyle(
//                           fontSize: 20, color: Colors.white, letterSpacing: 2),
//                       decoration: InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusColor: Colors.white,
//                         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         labelStyle:
//                             TextStyle(fontSize: 23, color: Colors.white),
//                         floatingLabelStyle:
//                             TextStyle(fontSize: 25, color: Colors.white),
//                         labelText: "Name",
//                         fillColor: Colors.white,

//                         // isDense: true,
//                       ),
//                     ),
//                     TextFormField(
//                       controller: emailsup,
//                       style: TextStyle(
//                           fontSize: 20, color: Colors.white, letterSpacing: 2),
//                       decoration: InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusColor: Colors.white,
//                         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         labelStyle:
//                             TextStyle(fontSize: 23, color: Colors.white),
//                         floatingLabelStyle:
//                             TextStyle(fontSize: 25, color: Colors.white),
//                         labelText: "Email Address",
//                         fillColor: Colors.white,

//                         // isDense: true,
//                       ),
//                     ),
//                     TextFormField(
//                       controller: passwordsup,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                       decoration: InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusColor: Colors.white,
//                         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         labelStyle:
//                             TextStyle(fontSize: 23, color: Colors.white),
//                         floatingLabelStyle:
//                             TextStyle(fontSize: 25, color: Colors.white),
//                         labelText: "password",
//                         fillColor: Colors.white,
//                         suffixIcon: Icon(
//                           Icons.remove_red_eye,
//                           color: Colors.white,
//                         ),

//                         // isDense: true,
//                       ),
//                       obscureText: true,
//                       obscuringCharacter: '*',
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(double.infinity, 50),
//                           primary: Color.fromARGB(255, 118, 223, 105),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                       onPressed: () async {
//                         try {
//                           FirebaseAuth.instance.createUserWithEmailAndPassword(
//                               email: emailsup!.text.trim(),
//                               password: passwordsup!.text.trim());
//                         } on FirebaseAuthException catch (e) {
//                           print("$e" +
//                               "errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
//                         }

//                         // print(
//                         //     "${namesup!.text} ppppppppp  ${emailsup!.text}dddddddddddddddd ${passwordsup!.text}");
//                       },
//                       child: Text(
//                         "Signup",
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "Do have an accunt?",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   MaterialButton(
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Text(
//                         "Signin",
//                         style: TextStyle(
//                             color: const Color.fromARGB(255, 49, 90, 214),
//                             fontSize: 18),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => loginScreen(),
//                           ));
//                     },
//                     color: Colors.white,
//                     shape: StadiumBorder(),
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20)),
//                 color: Color.fromARGB(255, 36, 89, 170),
//               ),
//               height: 100,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class loginScreen extends StatefulWidget {
//   const loginScreen({Key? key}) : super(key: key);

//   @override
//   State<loginScreen> createState() => _loginScreenState();
// }

// class _loginScreenState extends State<loginScreen> {
//   bool loginstate = false;
//   final TextEditingController? passwordsup = TextEditingController();
//   final TextEditingController? emailsup = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 49, 90, 214),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                       child: const Text(
//                         "WELL COME BACK!",
//                         style: TextStyle(color: Colors.white, fontSize: 27.5),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Are you Driver?",
//                           style: TextStyle(color: Colors.white, fontSize: 20.5),
//                         ),
//                         CupertinoSwitch(
//                             trackColor:
//                                 const Color.fromARGB(255, 238, 242, 255),
//                             thumbColor: Colors.white,
//                             activeColor:
//                                 const Color.fromARGB(255, 233, 235, 236),
//                             value: loginstate,
//                             onChanged: (val) {
//                               setState(() {});
//                               loginstate = val;
//                             })
//                       ],
//                     ),
//                     TextFormField(
//                       controller: emailsup,
//                       style: TextStyle(
//                           fontSize: 20, color: Colors.white, letterSpacing: 2),
//                       decoration: InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusColor: Colors.white,
//                         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         labelStyle:
//                             TextStyle(fontSize: 23, color: Colors.white),
//                         floatingLabelStyle:
//                             TextStyle(fontSize: 25, color: Colors.white),
//                         labelText: "Email Address",
//                         fillColor: Colors.white,

//                         // isDense: true,
//                       ),
//                     ),
//                     TextFormField(
//                       controller: passwordsup,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                       decoration: InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusColor: Colors.white,
//                         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         labelStyle:
//                             TextStyle(fontSize: 23, color: Colors.white),
//                         floatingLabelStyle:
//                             TextStyle(fontSize: 25, color: Colors.white),
//                         labelText: "password",
//                         fillColor: Colors.white,
//                         suffixIcon: Icon(
//                           Icons.remove_red_eye,
//                           color: Colors.white,
//                         ),

//                         // isDense: true,
//                       ),
//                       obscureText: true,
//                       obscuringCharacter: '*',
//                     ),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Forget Password?",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(double.infinity, 50),
//                           primary: Color.fromARGB(255, 118, 223, 105),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                       onPressed: () async {
//                         try {
//                           FirebaseAuth.instance.signInWithEmailAndPassword(
//                               email: emailsup!.text.trim(),
//                               password: passwordsup!.text.trim());
//                         } on FirebaseAuthException catch (e) {
//                           print("$e errorrrrrrrrrrrrrrrrrrrrrrrrrrr");
//                         }
//                       },
//                       child: Text(
//                         "Signin",
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "Don't have an accunt?",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   MaterialButton(
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Text(
//                         "Signup",
//                         style: TextStyle(
//                             color: const Color.fromARGB(255, 49, 90, 214),
//                             fontSize: 18),
//                       ),
//                     ),
//                     onPressed: () {},
//                     color: Colors.white,
//                     shape: StadiumBorder(),
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20)),
//                 color: Color.fromARGB(255, 36, 89, 170),
//               ),
//               height: 100,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// rgb(36, 89, 170)
