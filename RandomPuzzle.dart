import 'dart:math';

import 'package:flutter/material.dart';

class RandomPuzzle extends StatefulWidget {
  const RandomPuzzle({Key? key}) : super(key: key);

  @override
  State<RandomPuzzle> createState() => _RandomPuzzleState();
}

class _RandomPuzzleState extends State<RandomPuzzle> {
  // CreateState
  // Initstate
  // Build

  List<String> ll = [];

  @override
  void initState() {
    super.initState();


    // ll = List.filled(9, "1");

    // print("====$rr");

    for (int i = 0; i < 9; i++) {
      while (true) {
        int rr = Random().nextInt(9);
        if (!ll.contains("$rr")) {
         ll.add("$rr");
          break;
        }
      }

      print("==$ll");
    }
    print("==$ll");
    for(int i = 0 ; i < 9 ; i++)
      {
        if(ll[i]=="0")
          {
            ll[i]="";
            break;
          }
      }
    print("==$ll");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
