// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// class Mainprovider extends ChangeNotifier {
//   // int? age;
//   bool? value;
//   String ilegibility = " ";
//   void check(int age) {
//     if (age >= 18) {
//       ilegibility = "you can derive..";
//       value = true;
//       notifyListeners();
//     } else {
//       ilegibility = "you can not derive..";
//       value = false;
//       notifyListeners();
//     }
//   }
// }

class Colored extends ChangeNotifier {
  Color color = Colors.red;
  Color icon = Colors.white;
  Color colour = Colors.black;
  void colorpiker(colored) {
    color = colored;
    notifyListeners();
  }

  int? live;
  void l(int index) {
    live = index;
    notifyListeners();
  }

  void alive(int a) {
    if (a == live) {
      icon = const Color.fromARGB(255, 146, 32, 32);
      colour = const Color.fromARGB(255, 14, 71, 177);
      notifyListeners();
    } else {
      icon = Colors.black;
      colour = Colors.white;
      notifyListeners();
    }
  }
}
// class Colory extends ChangeNotifier {
//   Color cactive =  const Color.fromARGB(255, 8, 4, 233);
//   Color cinactive =  const Color.fromARGB(255, 8, 4, 233);
//   void colorchecker() {
//     color = cactive;
//     notifyListeners();
//   }
// }
