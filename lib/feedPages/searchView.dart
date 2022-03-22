import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:susell/dimensions/dimensions.dart';
import 'package:susell/feedPages/discount.dart';

class Search extends StatefulWidget {

  const Search({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {

  var list =[];
  Map<String,dynamic>? itemMap;
  bool isLoading = false;
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  bool isSearching = false;

  static const LatLng _center = const LatLng(40.89193877162805, 29.377914784885466);



  TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });

    await _firestore.collection('products').where('name', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        itemMap = value.docs[0].data();
        isLoading = false;
      });
      print(itemMap);
    } );

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      onSearch();
                    },
                  ),

                  hintText: '    Search...',
                  border: InputBorder.none
              ),

            ),
          ),


        ),),
      body: isLoading ?
      Discount() : OutlinedButton(
        onPressed: (){},

    child: itemMap != null ? ListTile(
      title: Card(
        child: ListTile(
          title: Text(itemMap!['name']),
            onTap: (){
              var results;

              productsCollection.doc(_search.text).get().then((value) async{

                String name = value["name"];
                int price = value["price"];
                String des = value["description"];
                String owner = value["owner"];
                Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                String url = await firebaseStorageRef.getDownloadURL();

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => pageP(context, name, price, des, owner, url, 'https://image.winudf.com/v2/image/Y29tLmJhbGVmb290Lk1vbmtleURMdWZmeVdhbGxwYXBlcl9zY3JlZW5fMF8xNTI0NTE5MTEwXzAyOA/screen-0.jpg?fakeurl=1&type=.jpg')));

              });


            },
          ),
        ),
      //subtitle: Text(itemMap!['price']),
      ): Discount(),

    ) ,

    );

  }

  Widget searchPage(){
    TextEditingController control = TextEditingController();

    return TextField(
      controller: control,
      decoration: InputDecoration(
        icon: Icon(Icons.search,
        color: Colors.green),

      ),

    );


  }
  var markers = {Marker(markerId: MarkerId('x'), position: _center )};
  late User firebaseUser;
  Future getProPhoto() async{
    firebaseUser =  await FirebaseAuth.instance.currentUser!;
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${firebaseUser.email}');
    String urlOwner = await firebaseStorageRef.getDownloadURL();
  }


  zoomPhoto(BuildContext context, String url) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 400,
        width: 300,
        child: PhotoView(
          imageProvider: Image.network(url).image,
          initialScale: PhotoViewComputedScale.contained * 0.8,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 5,
          basePosition: Alignment.center,
          backgroundDecoration: BoxDecoration(color: Colors.white),
        ),
      ),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(alert);
        return alert;
      },
    );
  }
  Widget pageP(BuildContext context, var name, var price, var des, var owner, var url, var urlOwner){

    return Scaffold(

      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: GestureDetector(
                    onTap: (){
                      zoomPhoto(context, url);
                    },
                    child: Image.network(url),
                  ),


                  height: 400,
                  width: 500,
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    Card(
                      shadowColor: Colors.teal,
                      elevation: 4,
                      child: ListTile(
                        onTap: () {},
                        leading: ClipOval(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Image.network(urlOwner),
                          ),
                        ),
                        title: Text(owner),
                        subtitle: Row(children: [
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star_border_outlined, size: 14,),
                          Text('  4', style: TextStyle(color: Colors.black)),
                        ],),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // TODO
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // TODO
                              },
                            ),
                            SizedBox(width: 110),
                            Text('${price.toString()} TL'),
                            SizedBox(width: 10),

                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.teal),
                              ),
                              onPressed: () {},
                              child: Text('Add To Card',
                                style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),


                      ],
                    ),
                    Row(
                      children: [
                        Text(des),

                      ],
                    ),
                    Divider(thickness: 2),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 350,
                height: 200,
                child: GoogleMap(
                  buildingsEnabled: true,
                  markers: markers,
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 13.0,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shadowColor: Colors.teal,
                    color: Colors.teal[50],
                    child: ListTile(
                      title: Card(child: Column(
                        children: [
                          SizedBox(height: 14),
                          Text('COMMENTS'),
                          SizedBox(height: 14),
                        ],
                      ),),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 28),
                          Divider(thickness: 2,),
                          Row(
                            children: [
                              Text('Good'),
                            ],
                          ),
                          Divider(thickness: 2,),
                          Row(
                            children: [
                              Text('Good'),
                            ],
                          ),
                          Divider(thickness: 2,),
                          Row(
                            children: [
                              Text('Good'),
                            ],
                          ),
                          Divider(thickness: 2,),
                        ],
                      ),
                    ),

                  ),

                ],
              ),

            ],
          ),
        ),
    ),
    );




  }
  Card cards(String name, int price, String url) {
    return Card(
      child: ListTile(
        leading: Image.network(url),
        title: Text(name),
        subtitle: Text(price.toString()),
        onTap: () async {
          var result;
          String des;
          String owner;
          var loc;
          await productsCollection.doc(name).get().then((value) {
            result = (value.data());
            des = result["description"];
            owner = result["owner"];
            loc = result["location"];

            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    pageP(context, name, price, des, loc, owner, url)));
          });
        },

      ),
    );

  }
  Widget categoryPage(String category, var list, var color) {

    return Scaffold(

      appBar: AppBar(
        title: Text(category),
        backgroundColor: color,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for(var card in list) card,
            ],
          ),
        ),


      ),

    );
  }
}


