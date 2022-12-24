import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pt extends StatefulWidget {
  const pt({Key? key}) : super(key: key);

  @override
  State<pt> createState() => _ptState();
}

class _ptState extends State<pt> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    virat();
  }
 Future <void> virat() async {

   var url = Uri.https('https://jsonplaceholder.typicode.com/photos');
   var response = await http.get(url);
   print('Response status: ${response.statusCode}');
   print('Response body: ${response.body}');

  List kk = jsonDecode(response.body);

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }


}
class photo {
  int? _albumId;
  int? _id;
  String? _title;
  String? _url;
  String? _thumbnailUrl;

  photo(
      {int? albumId,
        int? id,
        String? title,
        String? url,
        String? thumbnailUrl}) {
    if (albumId != null) {
      this._albumId = albumId;
    }
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (url != null) {
      this._url = url;
    }
    if (thumbnailUrl != null) {
      this._thumbnailUrl = thumbnailUrl;
    }
  }

  int? get albumId => _albumId;
  set albumId(int? albumId) => _albumId = albumId;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get url => _url;
  set url(String? url) => _url = url;
  String? get thumbnailUrl => _thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _thumbnailUrl = thumbnailUrl;

  photo.fromJson(Map<String, dynamic> json) {
    _albumId = json['albumId'];
    _id = json['id'];
    _title = json['title'];
    _url = json['url'];
    _thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this._albumId;
    data['id'] = this._id;
    data['title'] = this._title;
    data['url'] = this._url;
    data['thumbnailUrl'] = this._thumbnailUrl;
    return data;
  }
}

