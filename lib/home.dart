// import 'package:app1/addcar.dart';
// import 'package:app1/chat.dart';
import 'package:app1/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:app1/notify.dart';
// import 'package:app1/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.search,
                  color: Color.fromARGB(255, 163, 158, 158),
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: RichText(
            text: const TextSpan(
                style: TextStyle(fontSize: 20, fontFamily: "Sans Serif fonts"),
                children: <TextSpan>[
                  TextSpan(
                      text: "Choose",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontSize: 20,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: " a ",
                      style: TextStyle(color: Color.fromARGB(255, 80, 78, 78))),
                  TextSpan(
                    text: "Car",
                    style: TextStyle(
                      color: Color.fromARGB(255, 80, 78, 78),
                    ),
                  )
                ]),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Brands",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                    // addAutomaticKeepAlives: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Brand(
                        colour: Colors.white,
                        icon: Colors.black,
                        index: index,
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Available Car"),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined))
                ],
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('item').snapshots(),
                builder: (context, snapshot) {
                  List<String> titleDataList = [];
                  List<String> priceList = [];
                  List<String> discriptionList = [];
                  List<String> photourlsList = [];
                  List<String> emailList = [];
                  if (snapshot.hasData) {
                    final datum = snapshot.data!.docs;
                    for (var data in datum) {
                      titleDataList.add('${data.data()['title']}');
                      priceList.add('${data.data()['price']}');
                      ;
                      discriptionList.add('${data.data()['decription']}');
                      ;
                      photourlsList.add('${data.data()['imageurl']}');
                      emailList.add('${data.data()['useremail']}');
                    }
                    // print(titleDataList);
                  }
                  return (snapshot.hasData)
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: height / 1250,
                                    crossAxisCount: 2),
                            itemCount: emailList.length,
                            semanticChildCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Image(image: NetworkImage("url",),)
                                    CircleAvatar(
                                      radius: 75,
                                      child: Image.network(
                                        photourlsList[index],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          titleDataList[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: width / 18,
                                              color: Color.fromARGB(
                                                  255, 177, 175, 175)),
                                        ),
                                        Spacer(),
                                        // IconButton(onPressed: (), icon: icon)
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                          size: height / 30,
                                        ),
                                        SizedBox(
                                          width: width / 50,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Rs ${priceList[index]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: width / 20,
                                          color:
                                              Color.fromARGB(255, 32, 27, 27)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                          size: width / 20,
                                        ),
                                        SizedBox(
                                          width: width / 90,
                                        ),
                                        Text("Now"),
                                        Spacer()
                                      ],
                                    ),
                                  ],
                                ),
                                // color: Colors.amber,
                                // height: height / 2,
                                // width: width / 10,
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 4,
              //     itemBuilder: (context, index) {
              //       return AvaliableCar(
              //         index: index,
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class GridTilePart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return
//   }
// }

class AvaliableCar extends StatelessWidget {
  const AvaliableCar({
    @required this.index,
    Key? key,
  }) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => App2(image: "asset/c${index! + 1}.png")));
      }),
      child: Stack(
        children: [
          Container(
            height: 150,
            width: 200,
          ),
          Positioned(
            top: 20,
            child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "Tesla model x",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "2018",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 223, 209, 209)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "\$180",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                  text: "/day",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 223, 209, 209)),
                                )
                              ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Container(
                            height: 30,
                            width: 100,
                            child: const Center(
                                child: Text(
                              "Detail",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 8, 4, 233),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 226, 223, 223)
                            .withOpacity(0.5),
                        // spreadRadius: 5,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      )
                    ]),
                height: 100,
                width: 320),
          ),
          Positioned(
              left: 10,
              child: Transform.scale(
                scaleX: -1,
                child: Image.asset(
                  "asset/c${index! + 1}.png",
                  width: 190,
                ),
              )),
        ],
      ),
    );
  }
}

class Brand extends StatefulWidget {
  const Brand({
    this.index,
    this.icon,
    this.colour,
    Key? key,
  }) : super(key: key);
  final int? index;
  final Color? icon;
  final Color? colour;

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  int a = 0;
  List<String> name = [
    "asset/tesla.png",
    "asset/acura.png",
    "asset/ford.png",
    "asset/suzuki.png",
  ];
  Color color = Colors.white;
  Color iconcolor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        a = 1;
        setState(() {
          if (a == 1) {
            color = const Color.fromARGB(255, 8, 4, 233);
            iconcolor = Colors.white;
            a = 0;
          } else {
            Color color = Colors.white;
            Color iconcolor = Colors.black;
          }
        });
      },
      child: Row(
        children: [
          Container(
            child: widget.index == 0
                ? const Center(child: Text("All"))
                : Center(
                    child: Image.asset(
                      name[widget.index!.toInt() - 1],
                      color: iconcolor,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
            decoration: BoxDecoration(
                color: widget.index == 0
                    ? const Color.fromARGB(255, 207, 203, 203)
                    : color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 226, 223, 223)
                        .withOpacity(0.5),
                    // spreadRadius: 5,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  )
                ]),
            height: 70,
            width: 70,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
