import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:susell/firebase/db.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class addPro extends StatefulWidget {
  const addPro({Key? key}) : super(key: key);


  @override
  State<addPro> createState() => _addProState();
}

class _addProState extends State<addPro> {



  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  TextEditingController nametxt = new TextEditingController();
  TextEditingController desctxt = new TextEditingController();
  TextEditingController commenttxt = new TextEditingController();
  TextEditingController inttxt = new TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  DBService db = DBService();
  Widget pageP(BuildContext context, String name){
    return Scaffold(
      appBar: AppBar(
        title: Text(nametxt.text),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, '/feed');
              },
              icon: FaIcon(FontAwesomeIcons.windowClose))
        ],
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Image.file(File(_image!.path)),
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
                        onTap: (){},
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal[100],
                        ),
                        title: Text(name),
                        subtitle: Row(children: [
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star, size: 14,),
                          Icon(Icons.star_border_outlined, size: 14,),
                          Text( '  4', style: TextStyle(color: Colors.black)),
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
                            SizedBox(width: 160),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.teal),
                              ),
                              onPressed: (){},
                              child: Text('Add To Card', style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),

                      ],
                    ),
                    Divider(thickness: 2),
                  ],
                ),
              ),
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



  var categories = [
    MultiSelectItem('Dorm', 'Dorm'),
    MultiSelectItem('Tech', 'Tech'),
    MultiSelectItem('Rides', 'Rides'),
    MultiSelectItem('Tickets', 'Tickets'),
    MultiSelectItem('Clothes', 'Clothes'),
   ];


  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  String dropdownValue = 'Choose Category';

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${nametxt.text}');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print("Upload complete");
    } on FirebaseException catch(e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: _image != null
                          ? Image.file(File(_image!.path)) : TextButton(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.teal,
                          size: 150,
                        ),
                        onPressed: pickImage,
                      )
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: nametxt,

                  decoration: InputDecoration(
                    hintText: 'NAME',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),

                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: desctxt,

                  decoration: InputDecoration(
                    hintText: 'DESCRIPTION',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),

                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: inttxt,

                  decoration: InputDecoration(
                    hintText: 'PRICE',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),

                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width:1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepOrangeAccent),
                    underline: Container(
                      height: 2,
                      color: Colors.deepOrangeAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      print(dropdownValue);
                    },
                    items: <String>['Choose Category', 'Dorm', 'Tech', 'Rides', 'Tickets', 'Studies']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                      ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(

                      flex: 1,
                      child: ElevatedButton(

                        child: Text('ADD LOCATION',),
                        onPressed: (){
                          Navigator.pushNamed(context, '/map');
                        },
                        style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all(Colors.teal),

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, '/feed');
                          },
                          child: Text('CANCEL'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(

                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                          ),

                          onPressed: () {
                            uploadImageToFirebase(context);
                            setState(() async {
                              User firebaseUser = await FirebaseAuth.instance
                                  .currentUser!;
                              db.addProductt(nametxt.text, desctxt.text,
                                  int.parse(inttxt.text), GeoPoint(36, 45),
                                  firebaseUser.email);
                              db.addToCard(nametxt.text, desctxt.text,
                                  int.parse(inttxt.text), dropdownValue,
                                  GeoPoint(36, 45), firebaseUser.email);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      pageP(context, '${firebaseUser.email}')));
                            });

                          },
                          child: Text('SAVE'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
