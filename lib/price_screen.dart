import 'package:flutter/material.dart';
import 'coin_data.dart';

const apiKey = 'cf302b79-d589-4772-b1ba-4a1ffd489acf';

class PriceScreen extends StatefulWidget {

  PriceScreen({this.coinData});

  final coinData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String bitcoinValueInUSD = '?';
  String ethereumValueInUSD = '?';
  String litecoinValueInUSD = '?';

  void getData() async {
    try {
      double data1 = await CoinData().getBitCoinData(selectedCurrency);
      double data2 = await CoinData().getEthereumCoinData(selectedCurrency);
      double data3 = await CoinData().getLiteCoinData(selectedCurrency);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        bitcoinValueInUSD = data1.toStringAsFixed(0);
        ethereumValueInUSD = data2.toStringAsFixed(0);
        litecoinValueInUSD = data3.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }
  // CoinData coin = CoinData();
  String selectedCurrency = 'USD';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.purple,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $bitcoinValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.purple,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethereumValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.purple,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $litecoinValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.purple,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: [
                  for (String currency in currenciesList)
                    DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                    )
                ],
                onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
                getData();
            }),
          ),
        ],
      ),
    );
  }
}
