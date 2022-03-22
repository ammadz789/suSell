import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:susell/routes/feedView.dart';
import 'package:susell/main.dart';

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {

  late Razorpay razorpay;
  TextEditingController textEditingController= new TextEditingController();


  @override
  void initState() {
    super.initState();

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
      "amount" : num.parse('2000')*100,
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

  showAlertDialog(BuildContext context) {

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
      title: Icon(Icons.check, size: 100, color: Colors.deepOrangeAccent,),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text('PAY'),
      ),
      body: showAlertDialog(context),
    );
  }
}
