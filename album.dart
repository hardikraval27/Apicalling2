import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class album extends StatefulWidget {
  const album({Key? key}) : super(key: key);

  @override
  State<album> createState() => _albumState();
}

class _albumState extends State<album> {
  List<albm> mydata2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    api2();
  }

  Future<void> api2() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List bb = jsonDecode(response.body);
    for (int i = 0; i < bb.length; i++) {
      albm nn = albm.fromJson(bb[i]);
      setState(() {
        mydata2.add(nn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: mydata2.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${mydata2[index].title}"),
            subtitle: Text("${mydata2[index].id}"),
            leading: Text("${mydata2[index].userId}"),
          );
        },
      ),
    );
  }
}

class albm {
  int? _userId;
  int? _id;
  String? _title;

  albm({int? userId, int? id, String? title}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
  }

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get title => _title;

  set title(String? title) => _title = title;

  albm.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['id'] = this._id;
    data['title'] = this._title;
    return data;
  }
}
