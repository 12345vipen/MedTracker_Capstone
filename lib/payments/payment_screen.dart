import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

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
      "amount": num.parse(textEditingController.text) * 100,
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
    textEditingController.clear();
  }

  void handlerErrorFaliure(PaymentFailureResponse response) {
    print("payment Error");
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text("Payment Failed",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    textEditingController.clear();
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text("Uable to open External Wallet",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Pay your bills'),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xffe8eaf6),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 52,
            ),
            Image(image: AssetImage('assets/logo.jpg')),
            SizedBox(
              height: 42,
            ),
            Flexible( 
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "Amount to pay"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: ElevatedButton(
                  onPressed: () {
                    openCheckout();
                  },
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
