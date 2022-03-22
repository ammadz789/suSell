import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/firebase/auth.dart';
import 'package:susell/product/product.dart';
import 'package:susell/profile/editProfile.dart';
import 'package:susell/styles/styles.dart';
import 'package:path/path.dart';

class profileView extends StatefulWidget {



  profileView({Key? key}) : super(key: key);


  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {


  AuthService auth = AuthService();
  bool showPassword = false;
  image img = image();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  //late String url = 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';

  late String url;
  late User firebaseUser;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    url = 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';

  }




  
  Future<void> getData() async {
    // Get docs from collection reference

    User firebaseUser =  await FirebaseAuth.instance.currentUser!;
    //QuerySnapshot querySnapshot = await userCollection.get();

      //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    //print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),
                ],
              ),
              Center(

                child: ClipOval(
                  child: CircleAvatar(
                    radius: 60,
                    child: Image.network(url),
                  ),
                ),



              ),
              SizedBox(height: 20),
              Center(child: Text('Name'),),
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 16,),
                  Icon(Icons.star, size: 16),
                  Icon(Icons.star, size: 16),
                  Icon(Icons.star_border_outlined, size: 16),
                  Icon(Icons.star_border_outlined, size: 16),

                ],),),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              ListTile(

                title: Text('My Products'),

                leading: Icon(Icons.language, color: Colors.black,),

                onTap: () {
                  User firebaseUser =  FirebaseAuth.instance.currentUser!;
                  //getData();
                  userCollection.doc(firebaseUser.email).get().then((value){
                    print(value.data());
                  });

                },
              ),
              ListTile(
                title: Text('My Previous Orders'),

                leading: Icon(Icons.shopping_cart_outlined, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('My Favorites'),

                leading: Icon(Icons.favorite, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('My Bookmarks'),

                leading: Icon(Icons.bookmark, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('My Comments'),

                leading: Icon(Icons.comment, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('My discounts&special offers'),

                leading: FaIcon(FontAwesomeIcons.ticketAlt, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('My Adress'),

                leading: Icon(Icons.location_on, color: Colors.black),

                onTap: () {},
              ),
              ListTile(
                title: Text('Help'),

                leading: Icon(Icons.help, color: Colors.black),

                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: AppColors.textColor,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}


