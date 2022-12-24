import 'package:flutter/material.dart';

class dummy extends StatefulWidget {

   List<String> images;
   dummy(this.images);
  @override
  State<dummy> createState() => _dummyState();
}
class _dummyState extends State<dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  PageView.builder(
    itemCount: widget.images.length,
        itemBuilder: (context, index)
    {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.5,
        width: MediaQuery
            .of(context)
            .size
            .height * 0.5,

        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "${widget.images[index]}",
                ),
                fit: BoxFit.contain)),);
    },));
  }
}


