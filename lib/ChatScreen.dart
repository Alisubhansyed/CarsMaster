import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatContorlller = TextEditingController();
  @override
  void initState() {
    getChatDataList();
    super.initState();
  }

  void getChatDataList() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('Message').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Subhan",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('Message').snapshots(),
              builder: (context, snapshot) {
                List<String> messageDataList = [];
                List<String> messageList = [];
                if (snapshot.hasData) {
                  final message = snapshot.data!.docs;
                  for (var messaged in message) {
                    messageDataList.add('${messaged.data()['text']}');
                    messageList.add('${messaged.data()['sender']}');
                  }
                  print(messageDataList);
                }
                return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: (messageDataList.length != 0)
                        ? messageDataList.length
                        : 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: height / 70,
                          ),
                          Container(
                              width: width / 1.1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    margin: (messageList[index] ==
                                            FirebaseAuth
                                                .instance.currentUser!.email)
                                        ? EdgeInsets.only(left: width / 5.5)
                                        : null,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: width / 1.4,
                                    child: ListTile(
                                      title: Text("${messageDataList[index]}"),
                                      subtitle: Text("56:6"),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      );
                    });
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width / 1.28,
                  child: TextField(
                    controller: chatContorlller,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 122, 119, 119)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 4, 233),
                          )),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 4, 233),
                          )),
                      focusColor: const Color.fromARGB(255, 8, 4, 233),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      labelStyle: const TextStyle(
                        fontSize: 23,
                        color: Color.fromARGB(255, 8, 4, 233),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 8, 4, 233),
                      ),

                      // isDense: true,
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 8, 4, 233),
                  onPressed: () async {
                    FirebaseFirestore.instance.collection('Message').add({
                      'text': chatContorlller.value.text,
                      'sender':
                          FirebaseAuth.instance.currentUser!.email.toString(),
                    });
                    chatContorlller.clear();
                  },
                  child: const Icon(Icons.send),
                )
              ],
            ),
            SizedBox(
              height: height / 80,
            ),
          ],
        ),
      ),
    );
  }
}
