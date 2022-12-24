import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class comment extends StatefulWidget {
  const comment({Key? key}) : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  List<comment1> mydata1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apicalling1();
  }

  Future<void> apicalling1() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    debugPrint(response.body);

    List vv = jsonDecode(response.body);

    for (int i = 0; i < vv.length; i++) {
      comment1 bb = comment1.fromJson(vv[i]);
      setState(() {
        mydata1.add(bb);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: mydata1.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Text("title\n" + mydata1[index].id.toString()),
                  Text("name\n" + mydata1[index].name.toString()),
                  Text("email\n" + mydata1[index].email.toString()),
                  Text("body\n" + mydata1[index].body.toString()),
                  Text("postid\n" + mydata1[index].postId.toString()),

                ],
              ),
            );
          }
          //   return ListTile(
          //     title: Text("${mydata1[index].name}"),
          //     subtitle: Text("${mydata1[index].id}"),
          //     leading: Text("${mydata1[index].email}"),
          //     trailing: Text("${mydata1[index].postId}"),
          //   );
          // },
          ),
    );
  }
}

class comment1 {
  int? _postId;
  int? _id;
  String? _name;
  String? _email;
  String? _body;

  comment1({int? postId, int? id, String? name, String? email, String? body}) {
    if (postId != null) {
      this._postId = postId;
    }
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (body != null) {
      this._body = body;
    }
  }

  int? get postId => _postId;

  set postId(int? postId) => _postId = postId;

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get email => _email;

  set email(String? email) => _email = email;

  String? get body => _body;

  set body(String? body) => _body = body;

  comment1.fromJson(Map<String, dynamic> json) {
    _postId = json['postId'];
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this._postId;
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['body'] = this._body;
    return data;
  }
}
