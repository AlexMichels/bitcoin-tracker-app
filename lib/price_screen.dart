import 'package:cryptotracker/application/networking.dart';
import 'package:cryptotracker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({required this.priceDataBTC});
  String priceDataBTC;

  

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'EUR';
  late String priceDataCache;



  
  cupertinoPickerCustom() {
    List<Widget> listOfItems = [];
    for (String currency in currenciesList) {
      Text item = Text(currency);
      listOfItems.add(item);
    }
    return CupertinoPicker(
      onSelectedItemChanged: (IndexOfItem) {
        
        
       setState(() {        
         updateUI(currenciesList[IndexOfItem+1]);
     
       });
       
       
      },
      itemExtent: 31.0,
      children: listOfItems,
    );
  }
  

  androidDropdopdown() {
    List<DropdownMenuItem<String>> itemList = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> item =
          DropdownMenuItem<String>(child: Text(currency), value: currency);
      itemList.add(item);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: itemList,
        onChanged: (value) {
          setState(() {
         
          });
        });
  }


 void updateUI(selectedCureeny) async{
   widget.priceDataBTC = await NetworkHelper(currency: selectedCureeny).requestApiData('BTC');
   selectedCurrency = selectedCureeny;

  
 }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      updateUI(currenciesList[0]);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: picker(),
      ),
    );
  }

List<Widget> picker(){
List<Widget> liste = [];
Widget downMenu = Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? cupertinoPickerCustom()
                  : androidDropdopdown());

for(String item in cryptoList){


Widget cardWidget = Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $item = ${widget.priceDataBTC} ${selectedCurrency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );

liste.add(cardWidget);
}
liste.add(SizedBox(height: 300));
liste.add(downMenu);
print(liste.length);
return liste.sublist(2,5);          
}

}


