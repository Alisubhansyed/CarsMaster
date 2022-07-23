import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool loginstate = false;
  final TextEditingController? passwordsup = TextEditingController();
  final TextEditingController? emailsup = TextEditingController();

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
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "WELL COME BACK!",
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
                            value: loginstate,
                            onChanged: (val) {
                              setState(() {});
                              loginstate = val;
                            })
                      ],
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
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
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
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailsup!.text.trim(),
                              password: passwordsup!.text.trim());
                        } on FirebaseAuthException catch (e) {
                          print("$e errorrrrrrrrrrrrrrrrrrrrrrrrrrr");
                        }
                      },
                      child: const Text(
                        "Signin",
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
                    "Don't have an accunt?",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  MaterialButton(
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            color: Color.fromARGB(255, 49, 90, 214),
                            fontSize: 18),
                      ),
                    ),
                    onPressed: () {},
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
