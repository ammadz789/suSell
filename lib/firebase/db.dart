import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final CollectionReference adsCollection = FirebaseFirestore.instance.collection('advertisements');
  final CollectionReference cardCollection = FirebaseFirestore.instance.collection('Card');

  Future addAdvertisement(String name) async{
    // TODO
  }

  Future addToCard(String name, String descrip, int price, String category, GeoPoint location, var owner) async{
    final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('$category');
    categoryCollection.doc(name).set({
      'name': name,
      'description': descrip,
      'price' : price,
      'location': GeoPoint(36,45),
      'owner': owner,
      'category': category,
    });
  }


  Future addUserAutoID(String name, String mail, String token) async {
    userCollection.doc(token).set({
      'name': name,
      'username': token,
      'email': mail
    })
    .then((value) => print('User added'))
    .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addProductt(String name, String descrip, int price,  GeoPoint location, var owner) async {
    productsCollection.doc(name).set({
      'name': name,
      'description': descrip,
      'price' : price,
      'location': location,
      'owner': owner,

    })
        .then((value) => print('Product added'))
        .catchError((error) => print('Error: ${error.toString()}'));


  }

  Future addUser(String name, String mail, String token) async {
    userCollection.doc(mail).set({
      'name': name,
      'username': token,
      'email': mail
    })
    .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addNewProduct(String name, String descrip, int price, String comment, GeoPoint location, var owner) async {
    productsCollection.doc(name).set({
      'name': name,
      'description': descrip,
      'price' : price,
      'comment': comment,
      'location': location,
      'owner': owner,
    });

  }

  Future update(String name) async {
    productsCollection.doc(name).update({
      'owner': name,
    });

  }
}