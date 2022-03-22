import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:susell/colors/colors.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:susell/feedPages/comments.dart';


class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {

  var saless = [];
  var sales30 = [];
  var sales50 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 340,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                var results;
                                var color = AppColors.appBarTitleC.withOpacity(.4);
                                CollectionReference categoryCollection = FirebaseFirestore.instance.collection('20Sale');
                                categoryCollection.get().then((querySnapshot) {
                                  int x = querySnapshot.docs.length;
                                  querySnapshot.docs.forEach((result) async {
                                    results = (result.data());
                                    String name = results["name"];
                                    int price = results["price"];
                                    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                                    String url = await firebaseStorageRef.getDownloadURL();
                                    (saless.length != x) ? saless.add(cards(name, price, url)): saless;
                                  });

                                });
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('20% Offers', saless, color)));

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.deepOrangeAccent,
                                ),
                                width: 50,
                                height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("20% Offers",
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: (){
                                var results;
                                var color = AppColors.appBarTitleC.withOpacity(.4);
                                CollectionReference categoryCollection = FirebaseFirestore.instance.collection('30Sale');
                                categoryCollection.get().then((querySnapshot) {
                                  int x = querySnapshot.docs.length;
                                  querySnapshot.docs.forEach((result) async {
                                    results = (result.data());
                                    String name = results["name"];
                                    int price = results["price"];
                                    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                                    String url = await firebaseStorageRef.getDownloadURL();
                                    (sales30.length != x) ? sales30.add(cards(name, price, url)): sales30;
                                  });

                                });
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('30% Offers', sales30, color)));

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.orangeAccent[100],
                                ),
                                width: 50,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("30% Offers",
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w400)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: (){
                                var results;
                                var color = AppColors.appBarTitleC.withOpacity(.4);
                                CollectionReference categoryCollection = FirebaseFirestore.instance.collection('50Sale');
                                categoryCollection.get().then((querySnapshot) {
                                  int x = querySnapshot.docs.length;
                                  querySnapshot.docs.forEach((result) async {
                                    results = (result.data());
                                    String name = results["name"];
                                    int price = results["price"];
                                    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                                    String url = await firebaseStorageRef.getDownloadURL();
                                    (sales50.length != x) ? sales50.add(cards(name, price, url)): sales50;
                                  });

                                });
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('50% Offers', sales50, color)));

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.deepOrange[300],
                                ),
                                width: 50,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("50% Offers",
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w400)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //SizedBox(height: 2,),
                  Container(
                    child: Text('Advertisements'),

                  ),
                  SizedBox(height: 4,),

                  Container(
                    height: 180,
                    child: GridView(children: [

                      GestureDetector(
                        onTap: () {},


                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: AppColors.appBarTitleC.withOpacity(.4),),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[

                                Text('',
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 20,
                                        //letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400)
                                )
                              ],)
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: AppColors.appBarTitleC.withOpacity(.4),),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text("",
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 20,
                                        //letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400)
                                )
                              ],)
                        ),
                      ),


                    ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),

    );


  }
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  CollectionReference sale20Collection = FirebaseFirestore.instance.collection('20Sale');
  final commentsRef = FirebaseFirestore.instance.collection('comments');
  final DateTime timestamp = DateTime.now();
  var prodID;
  static const LatLng _center = const LatLng(40.89193877162805, 29.377914784885466);
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
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Continue Shopping", style: TextStyle(color: Colors.deepOrangeAccent,),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Go to Card", style: TextStyle(color: Colors.deepOrangeAccent,),),
      onPressed:  () {
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Icon(Icons.check, size: 100, color: Colors.deepOrangeAccent,),
      content: Text("Product is added to your card", style: TextStyle(fontSize: 20),),
      actions: [
        cancelButton,
        continueButton,
      ],
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
  var markers = {Marker(markerId: MarkerId('x'), position: _center )};

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
  Widget pageP(BuildContext context, var name, var price, var des, var loc, var owner, var url) {
    //markers.add(loc);
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
                      child: Image.network(url)
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
                            child: Image.network(url),
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
                            IconButton(
                              icon: Icon(
                                  Icons.comment,
                                  color: Colors.black
                              ),
                              onPressed: () => showComments(
                                context,
                                postId :  prodID,
                              ),

                            ),
                            SizedBox(width: 20),
                            Text('${price.toString()} TL'),
                            SizedBox(width: 10),

                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.teal),
                              ),
                              onPressed: () {
                                sale20Collection.doc(name).set({
                                  'name': name,
                                  'description': des,
                                  'price' : price,
                                  //'location': location,
                                  'owner': owner,
                                });
                                showAlertDialog(context);
                              },
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




            ],
          ),
        ),
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