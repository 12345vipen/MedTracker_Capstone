import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HardwareOrder extends StatefulWidget {
  final int price;
  final String productName;
  final String name;
  final String phoneNo;
  const HardwareOrder({Key? key
  ,required this.name,required this.price,required this.phoneNo,required this.productName
  }) : super(key: key);

  @override
  _HardwareOrderState createState() => _HardwareOrderState();
}

class _HardwareOrderState extends State<HardwareOrder> {
  late Razorpay razorpay;
  final DBref = FirebaseDatabase.instance.reference();
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";

  _HardwareOrderState() {
    // very important if u wana change Future<String> into String
    getId().then((val) => setState(() {
      userId = val;
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFaliure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
  void openCheckout() {
    var options = {
      "key":"rzp_test_Hzo11p8AHGHGR7",
      "amount": widget.price * 100,
      "name":"MedTracker",
      "description":"Payment for the medications",
      "prefill":{
        "contact":"5252525252",
        "email":"dsalgo@gmail.com"
      },
      "external":{
        "wallets":["paytm","phonepe"]
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("payment success");
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text("Payment Success",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    DBref.child(userId).child("userData").child(widget.name).update({"${widget.productName}":true});
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void handlerErrorFaliure(PaymentFailureResponse response) {
    print("payment Error");
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text("Payment Failed",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text("Uable to open External Wallet",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm your order!"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Image(image: AssetImage('assets/logo.jpg')),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Card(
                  child: ListTile(
                    title: Text("No of items: 1"),
                    trailing: Icon(Icons.shopping_cart),
                    subtitle: Text("Recheck by clicking at Cart"),
                  ),
                ),
              ),
              Card(
                color: Colors.black54,
                child: ListTile(
                  title: Center(child: Text("Total Amount: ${widget.price} Rs",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  openCheckout();
                },
                child: Card(
                  color: Colors.deepPurple,
                  child: ListTile(title: Center(child: Text("Pay Now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  Future<String> getId() async {
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}
