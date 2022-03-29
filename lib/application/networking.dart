import 'dart:convert';

import 'package:cryptotracker/constants.dart';
import 'package:http/http.dart' as http;


class NetworkHelper{
NetworkHelper({required this.currency});
final String? currency;
late String roundedString;

Future<String> requestApiData(crypto) async{
var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$APIKEY');  
http.Response response = await http.get(url);
if(response.statusCode==200){
  String data = response.body;
  double unroundedRate = jsonDecode(data)['rate'];
   int roundedRate = unroundedRate.round();
  roundedString = roundedRate.toString();
  return(roundedString);  
}
throw 'Statuscode is not 200 error!';
}

Future<String> requestApiSpecificData(crypto) async{
var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$APIKEY');  
http.Response response = await http.get(url);
if(response.statusCode==200){
  String data = response.body;
  double unroundedRate = jsonDecode(data)['rate'];
   int roundedRate = unroundedRate.round();
  String roundedStrings = roundedRate.toString();
  return(roundedStrings);  
}
throw 'Statuscode is not 200 error!';
}

}