import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Demodesign extends StatefulWidget {
  const Demodesign({Key? key}) : super(key: key);

  @override
  State<Demodesign> createState() => _DemodesignState();
}

class _DemodesignState extends State<Demodesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {

          },
          child: Container(
            height: 200,
            width: 200,
            child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)),
                    depth: 10,
                    lightSource: LightSource.topLeft,
                    color: Colors.yellow
                ),
                child: Text("M")
            ),
          ),
        ),
      ),
    );
  }
}
