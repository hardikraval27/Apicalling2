import 'dart:convert';
import 'package:apicalling/album.dart';
import 'package:apicalling/comment.dart';
import 'package:apicalling/dummyjson.dart';
import 'package:apicalling/main.dart';
import 'package:apicalling/todos.dart';
import 'package:apicalling/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  comment(),
  ));
}
class api extends StatefulWidget {
  const api({Key? key}) : super(key: key);

  @override
  State<api> createState() => _apiState();
}
class _apiState extends State<api> {

  List<postdata> mydata=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forapicall();
  }
   Future<void>forapicall() async {

    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    debugPrint("${response.body}");

    List mm = jsonDecode(response.body);

    for(int i=0;i<mm.length;i++)
      {
        postdata vv= postdata.fromJson(mm[i]);
        setState(() {
          mydata.add(vv);
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Center(child: Text("my data"))),
      body: ListView.builder(itemCount: mydata.length,itemBuilder: (context, index) {
        return ListTile(
          title: Text("${mydata[index].title}"),
                subtitle: Text("${mydata[index].body}"),
                leading: Text("${mydata[index].id}"),
                trailing: Text("${mydata[index].userId}"),
        );
      },),
    );
  }
}
class postdata {
  int? _userId;
  int? _id;
  String? _title;
  String? _body;

  postdata({int? userId, int? id, String? title, String? body}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (body != null) {
      this._body = body;
    }
  }
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get body => _body;
  set body(String? body) => _body = body;

  postdata.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['id'] = this._id;
    data['title'] = this._title;
    data['body'] = this._body;
    return data;
  }
}
