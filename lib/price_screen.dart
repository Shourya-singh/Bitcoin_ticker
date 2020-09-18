import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  String exchangeBTC;
  String exchangeETH;
  String exchangeLTC;
  CoinData coinData = CoinData();

  void getExchange() async {
    double rateBTC = await coinData.getCoinData(selectedCurrency, 0);
    double rateETH = await coinData.getCoinData(selectedCurrency, 1);
    double rateLTC = await coinData.getCoinData(selectedCurrency, 2);
    setState(() {
      exchangeBTC = rateBTC.toStringAsFixed(0);
      exchangeETH = rateETH.toStringAsFixed(0);
      exchangeLTC = rateLTC.toStringAsFixed(0);
    });
  }

  CupertinoPicker iosPicker() {
    List<Widget> pickerList = [];
    for (String currency in currenciesList) {
      var newCurrencyPicker = Text(
        currency,
      );
      pickerList.add(newCurrencyPicker);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerList,
    );
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (String currency in currenciesList) {
      var newCurrency = DropdownMenuItem(
        child: Text(
          currency,
        ),
        value: currency,
      );
      currencyList.add(newCurrency);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) async {
        double rateBTC = await coinData.getCoinData(value, 0);
        double rateETH = await coinData.getCoinData(value, 1);
        double rateLTC = await coinData.getCoinData(value, 2);
        setState(() {
          exchangeBTC = rateBTC.toStringAsFixed(0);
          exchangeETH = rateETH.toStringAsFixed(0);
          exchangeLTC = rateLTC.toStringAsFixed(0);
          selectedCurrency = value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getExchange();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $exchangeBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 ETH = $exchangeETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 LTC = $exchangeLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidPicker() : iosPicker(),
          ),
        ],
      ),
    );
  }
}
