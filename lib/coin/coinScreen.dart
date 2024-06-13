import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:budget_tracker/coin/coinCard.dart';
import 'package:budget_tracker/coin/coinModel.dart';

class CoinScreen extends StatefulWidget {
  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late List<Coin> coinList;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    coinList = [];
    fetchCoin();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => fetchCoin());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> fetchCoin() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&x_cg_demo_api_key=CG-ovkDBXTdMtnA7FrWfZpnq7DN'));
      if (response.statusCode == 200) {
        List<dynamic> values = json.decode(response.body);
        if (values.isNotEmpty) {
          setState(() {
            coinList = values.map((e) => Coin.fromJson(e)).toList();
          });
        } else {
          print('API boş veri döndürüyor');
        }
      } else {
        print('Failed to load coins. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar için şeffaf arka plan
        title: Text(
          'Kripto Borsası',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green[500]!, Colors.blue[500]!], 
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [Colors.blue[500]!, Colors.green[500]!], 
          ),
        ),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: coinList.length,
            itemBuilder: (context, index) {
              return CoinCard(coin: coinList[index]);
            },
          ),
        ),
      ),
    );
  }
}



//  API HTTP  API KEY : https:api.coingecko.com/api/v3/ping?x_cg_demo_api_key=CG-ovkDBXTdMtnA7FrWfZpnq7DN  

