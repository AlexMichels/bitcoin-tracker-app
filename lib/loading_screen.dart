import 'package:cryptotracker/application/networking.dart';
import 'package:cryptotracker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void networkhandler() async {
    NetworkHelper nHelper = NetworkHelper(currency: 'EUR');
    String data = await nHelper.requestApiData('BTC');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
       priceDataBTC: data,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkhandler();
  }

  @override
  Widget build(BuildContext context) {
    //print('build called');
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
          ),
        ));
  }
}