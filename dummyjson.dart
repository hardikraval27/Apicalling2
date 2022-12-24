import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apicalling/dummy2.dart';

class dmjson extends StatefulWidget {
  const dmjson({Key? key}) : super(key: key);

  @override
  State<dmjson> createState() => _dmjsonState();
}
class _dmjsonState extends State<dmjson> {
  bool status = false;
  product? gg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicalling1();
  }

  Future<void> apicalling1() async {
    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mm = jsonDecode(response.body);
    setState(() {
      gg = product.fromJson(mm);

      status = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status
          ? ListView.builder(
              itemCount: gg!.products!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        InkWell( onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return dummy(gg!.products![index].images!);
                          },));
                        },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.network(
                                "${gg!.products![index].thumbnail}"),
                          ),

                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListTile(
                            title: Text(
                                "${gg!.products![index].title} |${gg!.products![index].brand} |${gg!.products![index].rating}"),
                            subtitle: Column(
                              children: [
                                Text(
                                    "${gg!.products![index].category} ||${gg!.products![index].description}||${gg!.products![index].stock} ||${gg!.products![index].discountPercentage}   "),
                                Text(
                                  "  price = ${gg!.products![index].price}",
                                  style: TextStyle(fontSize: 30,color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}

class product {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  product({this.products, this.total, this.skip, this.limit});

  product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
