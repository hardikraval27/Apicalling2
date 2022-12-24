import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class todos extends StatefulWidget {
  const todos({Key? key}) : super(key: key);

  @override
  State<todos> createState() => _todosState();
}
class _todosState extends State<todos> {
  List<tods> mydata3 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api3();
  }

  Future<void> api3() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List hh = jsonDecode(response.body);

    for (int i = 0; i < hh.length; i++) {
      tods tt = tods.fromJson(hh[i]);
      setState(() {
        mydata3.add(tt);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: mydata3.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${mydata3[index].title}"),
            subtitle: Text("${mydata3[index].id}"),
            leading: Text("${mydata3[index].userId}"),
            trailing: Text("${mydata3[index].completed}"),
          );
        },
      ),
    );
  }
}

class tods {
  int? _userId;
  int? _id;
  String? _title;
  bool? _completed;

  tods({int? userId, int? id, String? title, bool? completed}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (completed != null) {
      this._completed = completed;
    }
  }

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get title => _title;

  set title(String? title) => _title = title;

  bool? get completed => _completed;

  set completed(bool? completed) => _completed = completed;

  tods.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['id'] = this._id;
    data['title'] = this._title;
    data['completed'] = this._completed;
    return data;
  }
}
