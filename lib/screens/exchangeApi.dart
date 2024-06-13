import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyResponse {
  final bool success;
  final Result result;

  CurrencyResponse({required this.success, required this.result});

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyResponse(
      success: json['success'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final String base;
  final String lastupdate;
  final List<CurrencyData> data;

  Result({required this.base, required this.lastupdate, required this.data});

  factory Result.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<CurrencyData> dataList =
        list.map((i) => CurrencyData.fromJson(i)).toList();

    return Result(
      base: json['base'],
      lastupdate: json['lastupdate'],
      data: dataList,
    );
  }
}

class CurrencyData {
  final String code;
  final String name;
  final double rate;
  final String calculatedstr;
  final double calculated;

  CurrencyData(
      {required this.code,
      required this.name,
      required this.rate,
      required this.calculatedstr,
      required this.calculated});

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      code: json['code'],
      name: _translateCurrencyName(json['name']),
      rate: json['rate'].toDouble(), 
      calculatedstr: json['calculatedstr'],
      calculated: json['calculated'].toDouble(), 
    );
  }
}

String _translateCurrencyName(String name) {
  switch (name) {
    case 'United States Dollar':
      return 'Amerikan Doları';
    case 'Euro':
      return 'Euro';
    case 'British Pound':
      return 'İngiliz Sterlini';
    default:
      return name;
  }
}

Future<CurrencyResponse> fetchData() async {
  final url = Uri.parse(
      'https://api.collectapi.com/economy/currencyToAll?int=10&base=USD');
  final headers = {
    'authorization': 'apikey 5QowQjJePCTvw3WbWXyNYN:2sV54IQcRbLhNEbniTSZG8',
    'content-type': 'application/json',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return CurrencyResponse.fromJson(jsonResponse);
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}

class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  late Future<CurrencyResponse> futureCurrencyResponse;
  double? usdToTryRate;

  @override
  void initState() {
    super.initState();
    futureCurrencyResponse = fetchData();
  }

  Widget getCurrencyIcon(String code) {
    switch (code) {
      case 'USD':
        return Icon(Icons.attach_money);
      case 'EUR':
        return Icon(Icons.euro);
      case 'GBP':
        return Icon(Icons.money);
      default:
        return Icon(Icons.monetization_on);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Döviz Kurları',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.blue],
          ),
        ),
        child: FutureBuilder<CurrencyResponse>(
          future: futureCurrencyResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.result.data.isEmpty) {
              return Center(child: Text('Veri bulunamadı'));
            } else {
              
              usdToTryRate = snapshot.data!.result.data
                  .firstWhere((currency) => currency.code == 'TRY')
                  .rate;

              return ListView.builder(
                itemCount: snapshot.data!.result.data.length,
                itemBuilder: (context, index) {
                  var currency = snapshot.data!.result.data[index];
                  double tlEquivalent = (usdToTryRate != null) ? currency.rate * usdToTryRate! : 0.0;
                  return Card(
                    child: ListTile(
                      leading: getCurrencyIcon(currency.code),
                      title: Text('${currency.code} - ${currency.name}'),
                      subtitle: Text('Kur: ${currency.rate}\nTL Karşılığı: ${tlEquivalent.toStringAsFixed(2)}'),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



// API TOKEN CODE: apikey 5QowQjJePCTvw3WbWXyNYN:2sV54IQcRbLhNEbniTSZG8
// API TOKEN HTTP: https://api.collectapi.com/economy/currencyToAll?int=10&base=USD