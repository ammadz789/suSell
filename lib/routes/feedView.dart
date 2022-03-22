import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:susell/colors/colors.dart';
import 'package:susell/feedPages/Category.dart';
import 'package:susell/feedPages/notificationView.dart';
import 'package:susell/profile/profileView.dart';
import 'package:susell/feedPages/searchView.dart';
import 'package:susell/feedPages/settings.dart';
import 'package:susell/firebase/auth.dart';
import 'package:susell/firebase/db.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:susell/main.dart';



class FeedView extends StatelessWidget {

  AuthService auth = AuthService();
  DBService db = DBService();

  @override
  Widget build(BuildContext context) {

    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {


  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Category(),
    Search(observer: AppBase.observer, analytics: AppBase.analytics,),
    Settings1(analytics: AppBase.analytics, observer: AppBase.observer),
    profileView(),

  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  late int total_price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('Campus'),
        centerTitle: true,
        actions: <Widget>[
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationView()),
                  );
                },
              ),

            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                    var results;


                    final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Card');
                    categoryCollection.get().then((querySnapshot) {
                      int x = querySnapshot.docs.length;
                      querySnapshot.docs.forEach((result) async {
                        String name = result["name"];
                        int price = result["price"];
                        total_price = total_price + price;
                        print(total_price);
                        Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/${name}');
                        String url = await firebaseStorageRef.getDownloadURL();
                        (shop_cards.length != x) ? shop_cards.add(cards(name, price, url)): shop_cards;
                      });
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => cardPage(shop_cards)));
                  //Navigator.pushNamed(context, '/card');
                },
              ),
            ],
          ),
        ],

      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: AppColors.buttomNavigator,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: AppColors.buttomNavigator,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: AppColors.buttomNavigator,),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, color: AppColors.buttomNavigator,),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );


  }
  CollectionReference cardCollection = FirebaseFirestore.instance.collection('Card');
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  List<Card> shop_cards = [];
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
  Widget cardPage(var list) {


    return Scaffold(

      appBar: AppBar(
        title: Text('Card'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for(var card in list) card,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${total_price}  TL   '
                  ),
                  ElevatedButton(
                      onPressed: (){
                        showPay(context);

                        //Navigator.pushNamed(context, '/pay');
                      },
                      child: Text('Buy'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
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
  Widget pageP(BuildContext context, var name, var price, var des, var owner, var url) {

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
                            SizedBox(width: 70),
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

                              },
                              child: Text('Remove from Card',
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
        trailing: IconButton(icon: Icon(Icons.cancel, color: Colors.black,), onPressed: (){}),
        title: Text(name),
        subtitle: Text(price.toString()),
        onTap: () async {
          var result;
          String des;
          String owner;
          await cardCollection.doc(name).get().then((value) {
            result = (value.data());
            des = result["description"];
            owner = result["owner"];

            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    pageP(context, name, price, des, owner, url)));
          });
        },

      ),
    );

  }



  late Razorpay razorpay;
  TextEditingController textEditingController= new TextEditingController();


  @override
  void initState() {
    super.initState();
    total_price = 0;
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : 'rzp_test_oRUdVhQSvUhPoi',
      "amount" : num.parse('$total_price')*100,
      "name" : "SUsell",
      "description" : "Payment for your item(s):",

      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(){
    print('Payment Success!');
    Navigator.pushNamed(context, '/feed');
  }
  void handlerErrorFailure(){
    print('Payment Failure!');
  }
  void handlerExternalWallet(){
    print('External Wallet!');
  }

  showPay(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Continue Shopping", style: TextStyle(color: Colors.deepOrangeAccent,),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Pay now", style: TextStyle(color: Colors.deepOrangeAccent,),),
      onPressed:  () {
        openCheckout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          FaIcon(FontAwesomeIcons.creditCard, size: 70, color: Colors.black38,),
          SizedBox(width: 15),
          FaIcon(FontAwesomeIcons.moneyBill, size: 70, color: Colors.black38,),
        ],
      ),
      content: Text("You can continue shopping or pay now.", style: TextStyle(fontSize: 20),),
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



}

