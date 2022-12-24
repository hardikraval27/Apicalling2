import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';
import 'SplashCreen.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                autofocus: true,
                controller: username,
                decoration: InputDecoration(hintText: "Eneter Userbname",border: OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                controller: password,
                decoration: InputDecoration(hintText: "Pass",border: OutlineInputBorder()),
              )),
          ElevatedButton(
              onPressed: () async {
                String uname = username.text;
                String upass = password.text;

                Map mm = {"username": uname, "password": upass};
                var url = Uri.parse(
                    'https://pragneshzone.000webhostapp.com/Ecommer/classlogin.php');
                var response = await http.post(url, body: mm);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var map = jsonDecode(response.body);

                Logindata mm1 = Logindata.fromJson(map);

                if (mm1.connection == 1) {
                  if (mm1.result == 1) {
                    String? name = mm1.userdata!.nAME;
                    String? imagee = mm1.userdata!.iMAGEPATH;
                    String? userid = mm1.userdata!.iD;

                    SplashCreen.prefrs!.setString("NAME", name!);
                    SplashCreen.prefrs!.setString("Image", imagee!);
                    SplashCreen.prefrs!
                        .setString("Email", mm1.userdata!.eMAIL!);
                    SplashCreen.prefrs!.setString("id", userid!);
                    SplashCreen.prefrs!.setBool("loginstatus", true);

                    print("== $name == $imagee");

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return Homepage();
                      },
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User Not Found")));
                  }
                }
              },
              child: Text("Login"))
        ],
      ),
    );
  }

  bool Islogin = false;

  Future<void> forCheckstatus() async {
    SplashCreen.prefrs = await SharedPreferences.getInstance();

    setState(() {
      Islogin = SplashCreen.prefrs!.getBool("loginstatus") ?? false;
    });

    if (Islogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Loginpage();
        },
      ));
    }
  }
}

class Logindata {
  int? connection;
  int? result;
  Userdata? userdata;

  Logindata({this.connection, this.result, this.userdata});

  Logindata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? eMAIL;
  String? cONTACT;
  String? pASSWORD;
  String? iMAGEPATH;

  Userdata(
      {this.iD,
      this.nAME,
      this.eMAIL,
      this.cONTACT,
      this.pASSWORD,
      this.iMAGEPATH});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    eMAIL = json['EMAIL'];
    cONTACT = json['CONTACT'];
    pASSWORD = json['PASSWORD'];
    iMAGEPATH = json['IMAGEPATH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['EMAIL'] = this.eMAIL;
    data['CONTACT'] = this.cONTACT;
    data['PASSWORD'] = this.pASSWORD;
    data['IMAGEPATH'] = this.iMAGEPATH;
    return data;
  }
}
