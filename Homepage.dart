import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'SplashCreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> list = [View_product(), Addproduct()];

  int cnt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String name = SplashCreen.prefrs!.getString("NAME") ?? "";

    print("===$name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[cnt],
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                otherAccountsPictures: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))
                ],
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pragneshzone.000webhostapp.com/Ecommer/${SplashCreen.prefrs!.getString("Image") ?? ""}")),
                accountName:
                    Text("${SplashCreen.prefrs!.getString("NAME") ?? ""}"),
                accountEmail:
                    Text("${SplashCreen.prefrs!.getString("Email") ?? ""}")),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 0;
                });
              },
              title: Text(
                "View PRoduct",
              ),
              leading: Icon(Icons.shopping_cart),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 1;
                });
              },
              title: Text(
                "Add PRoduct",
              ),
              leading: Icon(Icons.shopping_cart),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Log Out",
              ),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}

class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  bool Isview = false;

  ViewProduct? jj;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ForViewProduct();
  }

  Future<void> ForViewProduct() async {
    String userid = SplashCreen.prefrs!.getString("id") ?? "";

    Map productmap = {
      "userid": userid,
    };
    var url = Uri.parse(
        'https://dishazone.000webhostapp.com/Ecommerce/classViewProduct.php');
    var response = await http.post(url, body: productmap);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var Dd = jsonDecode(response.body);

    jj = ViewProduct.fromJson(Dd);

    if (jj!.connection == 1) {
      if (jj!.result == 1) {
        setState(() {
          Isview = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Isview
        ? Scaffold(
            backgroundColor: Colors.yellow,
            body: ListView.builder(
              itemCount: jj!.productdata!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://dishazone.000webhostapp.com/Ecommerce/${jj!.productdata![index].proimage}")),
                  title: Text("${jj!.productdata![index].productname}"),
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class View_product extends StatefulWidget {
  const View_product({Key? key}) : super(key: key);

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            final ImagePicker _picker = ImagePicker();
                            // Capture a photo
                            final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              img = photo!.path;
                            });
                          },
                          icon: Icon(Icons.camera),
                          label: Text("Camera")),
                      ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            final ImagePicker _picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {
                              img = image!.path;
                            });
                          },
                          icon: Icon(Icons.photo),
                          label: Text("Gallary"))
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              maxRadius: 50,
              backgroundImage: FileImage(File(img)),
            )),
        ElevatedButton(
            onPressed: () async {
              //        image   > byte array > string

              List<int> baray = File(img).readAsBytesSync();
              String productimage = base64Encode(baray);
              String userid = SplashCreen.prefrs!.getString("id") ?? "";

              Map productmap = {
                "pname": "android",
                "prize": "9000",
                "des": "High Quality",
                "userid": userid,
                "pimagedata": productimage
              };
              var url = Uri.parse(
                  'https://dishazone.000webhostapp.com/Ecommerce/classAddproduct.php');
              var response = await http.post(url, body: productmap);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
            },
            child: Text("Add Product")),
      ],
    ));
    ;
  }

  String img = "";
}

class ViewProduct {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  ViewProduct({this.connection, this.result, this.productdata});

  ViewProduct.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? productname;
  String? productprice;
  String? desctription;
  String? proimage;
  String? userid;

  Productdata(
      {this.id,
      this.productname,
      this.productprice,
      this.desctription,
      this.proimage,
      this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['Productname'];
    productprice = json['Productprice'];
    desctription = json['desctription'];
    proimage = json['proimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Productname'] = this.productname;
    data['Productprice'] = this.productprice;
    data['desctription'] = this.desctription;
    data['proimage'] = this.proimage;
    data['userid'] = this.userid;
    return data;
  }
}
