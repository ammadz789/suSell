import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/firebase/auth.dart';
import 'package:susell/firebase/db.dart';
import 'package:susell/product/product.dart';
import 'package:susell/profile/profileView.dart';
import 'package:susell/routes/feedView.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';



class editProfile extends StatefulWidget {



  const editProfile({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {

  AuthService auth = AuthService();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool showPassword = false;



  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: 75,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,

      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20,

            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
              ),

              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),

            ],
          ),

        ],
      ),

    );
  }
  Future takePhoto(ImageSource imageSource) async{
    final pickedFile = await _picker.getImage(
        source: imageSource,
    );
  }

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    User firebaseUser =  await FirebaseAuth.instance.currentUser!;
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${firebaseUser.email}');
    String url = await firebaseStorageRef.getDownloadURL();
    await firebaseUser.updatePhotoURL(url);
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print("Upload complete");
    } on FirebaseException catch(e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

  DBService db = DBService();

  final cntrl1 = TextEditingController();
  final cntrl2 = TextEditingController();
  final cntrl3 = TextEditingController();
  final cntrl4 = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedView()),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 80,
                        child: _image != null
                            ? (Image.file(File(_image!.path))) : Icon(
                            Icons.add_a_photo,
                            color: Colors.teal,
                            size: 100,
                        )

                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(

                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: AppColors.primary,

                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: AppColors.fill,
                            ),
                            onTap: pickImage,

                          ),
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("", "Username", false, cntrl1),

              buildTextField("", "E-mail", false, cntrl2),

              buildTextField("", "********", true, cntrl3),

              buildTextField("", "Location", false, cntrl4),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pop();

                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: AppColors.textColor)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      auth.updateName(cntrl1.text);
                      auth.updateEmail(cntrl2.text);
                      auth.updatePassword(cntrl3.text);
                      db.addUser(cntrl1.text, cntrl2.text, cntrl1.text);
                      uploadImageToFirebase(context);


                    },
                    color: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: AppColors.fill),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: control,
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