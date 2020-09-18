import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'F30C3C9E-AF13-4221-84DD-07C7E1250601';
const url = 'https://rest.coinapi.io/v1/exchangerate';
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

class CoinData {
  Future getCoinData(String selectedCurrency, int index) async {
    http.Response response = await http
        .get('$url/${cryptoList[index]}/$selectedCurrency?apikey=$apiKey');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var d = data['rate'];
      return d;
    } else {
      print(response.statusCode);
    }
  }
}
