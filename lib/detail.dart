// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerutility.dart';

class App2 extends StatelessWidget {
  const App2({this.image, Key? key}) : super(key: key);
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 34, 33, 33),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 10,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "asset/tesla.png",
                              height: 45,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                "Tesla Model S",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "2021",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Color.fromARGB(255, 196, 178, 178),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const Text(
                            "4.8",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Consumer<Colored>(
                  builder: ((context, provider, child) {
                    return ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(provider.color, BlendMode.hue),
                      child: Container(
                        // color: provider.color,
                        color: const Color.fromARGB(255, 34, 33, 33),
                        child: Image.asset(
                          image!,
                          width: 350,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 30,
                  width: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Colorppicker(
                        index: index,
                      );
                    },
                  ),
                )
              ],
            ),
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 34, 33, 33),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: const Text(
              "Specifications",
              // textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 34, 33, 33),
                      ),
                      height: 100,
                      width: 130,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                );
              },
            ),
          )),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Location",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          Icons.directions_walk_rounded,
                          color: Colors.grey,
                        ),
                        Text(
                          "344 m",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 8, 4, 233),
                    ),
                    Text(
                      "Mansfield Avenu,los Angeles,CA",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 138, 131, 131)),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            // height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "\$280",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const TextSpan(
                          text: "/day",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 129, 121, 121)))
                    ]))),
                Container(
                  height: 70,
                  width: 200,
                  child: const Center(
                      child: Text(
                    "Book now",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                  decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 8, 4, 233),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Colorppicker extends StatelessWidget {
  Colorppicker({
    this.index,
    Key? key,
  }) : super(key: key);
  final int? index;
  List<Color> color = [Colors.black, Colors.red, Colors.yellow, Colors.blue];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Provider.of<Colored>(context, listen: false)
                .colorpiker(color[index!.toInt()]);
            // print("object");
          },
          child: Container(
              decoration: BoxDecoration(
                  color: color[index!.toInt()],
                  borderRadius: BorderRadius.circular(120)),
              height: 23,
              width: 23),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
