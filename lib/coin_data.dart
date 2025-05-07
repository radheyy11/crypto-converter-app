import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'bffab585-6e1c-43aa-a66c-e6dd5bad5b14';

const coinGeckoURL = 'https://api.coingecko.com/api/v3/simple/price';
class CoinData {
  Future<dynamic> getBitCoinData(String selectedCurrency) async{
    String requestURLBTC = '$coinGeckoURL?ids=bitcoin&vs_currencies=$selectedCurrency';
    http.Response response = await http.get(Uri.parse(requestURLBTC));

    if (response.statusCode == 200) {

      var decodedData = jsonDecode(response.body);
      selectedCurrency = selectedCurrency.toLowerCase();
      var price = decodedData['bitcoin'][selectedCurrency];
      return double.tryParse(price.toString()) ?? 0.0;
    }
    else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<dynamic> getEthereumCoinData(String selectedCurrency) async{

    String requestURLETH = '$coinGeckoURL?ids=ethereum&vs_currencies=$selectedCurrency';
    http.Response res = await http.get(Uri.parse(requestURLETH));

    if (res.statusCode == 200) {

      var decodedData = jsonDecode(res.body);
      selectedCurrency = selectedCurrency.toLowerCase();
      var price = decodedData['ethereum'][selectedCurrency];
      return double.tryParse(price.toString()) ?? 0.0;
    }
    else {
      print(res.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<dynamic> getLiteCoinData(String selectedCurrency) async{

    String requestURLLTC = '$coinGeckoURL?ids=litecoin&vs_currencies=$selectedCurrency';
    http.Response resp = await http.get(Uri.parse(requestURLLTC));

    if (resp.statusCode == 200) {

      var decodedData = jsonDecode(resp.body);
      selectedCurrency = selectedCurrency.toLowerCase();
      var price = decodedData['litecoin'][selectedCurrency];
      return double.tryParse(price.toString()) ?? 0.0;
    }
    else {
      print(resp.statusCode);
      throw 'Problem with the get request';
    }
  }
}
