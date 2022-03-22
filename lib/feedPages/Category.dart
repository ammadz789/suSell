import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:susell/colors/colors.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:susell/firebase/db.dart';
import 'comments.dart';


class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {


  final commentsRef = FirebaseFirestore.instance.collection('comments');
  final DateTime timestamp = DateTime.now();
  var prodID;
  User? currentUser;
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  List<Card> techs = [];
  List<Card> dorms = [];
  List<Card> ridess = [];
  List<Card> ticketss = [];
  List<Card> studiess = [];
  List<Card> productss = [];



  //Set<Marker> markers;
  static const LatLng _center = const LatLng(40.89193877162805, 29.377914784885466);

  CollectionReference cardCollection = FirebaseFirestore.instance.collection('Card');
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
                                cardCollection.doc(name).set({
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fill,

      body: Container(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(children: [

          GestureDetector(
            onTap: () {
              var results;
              var color = AppColors.appBarTitleC.withOpacity(.4);
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('products');
              categoryCollection.get().then((querySnapshot) {
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {
                  results = (result.data());
                  String name = results["name"];
                  int price = results["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (productss.length != x) ? productss.add(cards(name, price, url)): productss;
                });

              });
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('All', productss, color)));

            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: AppColors.appBarTitleC.withOpacity(.4),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.apps, size: 50,
                      color: AppColors.textColor,),
                    Text("All",
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
            onTap: (){
              var results;
              var color = Colors.orangeAccent;
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Dorm');
              categoryCollection.get().then((querySnapshot) {
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {

                  results = (result.data());
                  String name = results["name"];
                  int price = results["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (dorms.length != x) ? dorms.add(cards(name, price, url)):dorms;

                });
              });

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('Dorm', dorms, color)));


            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.orangeAccent,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.door_front_door_sharp, size: 50,
                      color: AppColors.textColor,),
                    Text("Dorm",
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
            onTap: (){

              var results;
              var color = Colors.red;
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Tech');
              categoryCollection.get().then((querySnapshot){
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {

                  String name = result["name"];
                  int price = result["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (techs.length != x) ? techs.add(cards(name, price, url)) : techs;
                });
              });
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('Tech', techs, color)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.red,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.phone_android_sharp, size: 50,
                      color: AppColors.textColor,),
                    Text("Tech",
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
            onTap: (){
              var results;
              var color = Colors.green;
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Rides');
              categoryCollection.get().then((querySnapshot) {
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {

                  results = (result.data());
                  String name = results["name"];
                  int price = results["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (ridess.length != x) ? ridess.add(cards(name, price, url)): ridess;

                });
              });

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('Rides', ridess, color)));


            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.green,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.directions_car_sharp, size: 50,
                      color: AppColors.textColor,),
                    Text("Rides",
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
            onTap: (){
              var results;
              var color = Colors.pink;
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Tickets');
              categoryCollection.get().then((querySnapshot) {
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {

                  results = (result.data());
                  String name = results["name"];
                  int price = results["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (ticketss.length != x) ? ticketss.add(cards(name, price, url)): ticketss;
                });
              });

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('Tickets', ticketss, color)));


            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.pink,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.music_note_sharp, size: 50,
                      color: AppColors.textColor,),
                    Text("Tickets",
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
            onTap: (){
              var results;
              var color = Colors.deepPurpleAccent;
              CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Studies');
              categoryCollection.get().then((querySnapshot) {
                int x = querySnapshot.docs.length;
                querySnapshot.docs.forEach((result) async {

                  results = (result.data());
                  String name = results["name"];
                  int price = results["price"];
                  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                  String url = await firebaseStorageRef.getDownloadURL();
                  (studiess.length != x) ? studiess.add(cards(name, price, url)): studiess;

                });
              });

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => categoryPage('Studies', studiess, color)));


            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurpleAccent,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.menu_book_outlined, size: 50,
                      color: AppColors.textColor,),
                    Text("Studies",
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

            onTap: (){
              Navigator.pushNamed(context, '/addProduct');
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlueAccent,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.add, size: 50,
                      color: AppColors.textColor,),
                    Text("Add Product",
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
      )

      ),
    );
  }
}