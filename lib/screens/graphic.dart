import 'dart:math';
import 'package:budget_tracker/utils/icons_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphicScreen extends StatefulWidget {
  @override
  _GraphicScreenState createState() => _GraphicScreenState();
}

class _GraphicScreenState extends State<GraphicScreen>
    with SingleTickerProviderStateMixin {
  final AppIcons appIcons = AppIcons();
  late AnimationController _controller;
  bool _showMonthly = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleView() {
    setState(() {
      _showMonthly = !_showMonthly;
      _controller.reset();
      _controller.forward();
    });
  }

  List<TransactionData> _filterByMonth(
      List<TransactionData> transactions, int month) {
    return transactions
        .where((transaction) => transaction.date.month == month)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Harcama Grafigi',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('transactions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Bir hata oluştu: ${snapshot.error}');
                } else {
                  List<TransactionData> transactions = snapshot.data!.docs
                      .map((doc) => TransactionData.fromFirestore(doc))
                      .toList();

                  transactions.sort((a, b) => b.date.compareTo(a.date));

                  List<TransactionData> displayedTransactions = _showMonthly
                      ? _filterByMonth(transactions, DateTime.now().month)
                      : transactions;

                  
                  List<Color> colors = List.generate(
                      displayedTransactions.length,
                      (index) => getReadableColor(index));

                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: FadeTransition(
                          opacity: _controller,
                          child: PieChart(
                            PieChartData(
                              sections: List.generate(
                                displayedTransactions.length,
                                (index) => PieChartSectionData(
                                  value: displayedTransactions[index].amount,
                                  color: colors[index], // Renkleri kullan
                                  showTitle: false,
                                  radius: 100,
                                ),
                              ),
                              sectionsSpace: 2,
                              centerSpaceRadius: 60,
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment:
                            Alignment.center, // Butonu ortaya hizalamak için
                        child: ElevatedButton(
                          onPressed: _toggleView,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          child: Text(_showMonthly
                              ? 'Tüm Harcamaları Göster'
                              : 'Aylık Harcamaları Göster'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        flex: 4,
                        child: ListView.builder(
                          itemCount: displayedTransactions.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _controller.value,
                                  child: Card(
                                    color: colors[
                                        index], 
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: Icon(
                                          appIcons.getExpenseCategoryIcons(
                                              displayedTransactions[index]
                                                  .title)),
                                      title: Text(
                                          displayedTransactions[index].title),
                                      subtitle: Text(
                                          '${displayedTransactions[index].amount.toStringAsFixed(2)} TL'),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

 // Renklerin uyumu mavi-yesil zeminde okunabilmesi icin bu sekilde 
  Color getReadableColor(int index) {
    List<Color> colors = [
      Colors.amber.shade200,
      Colors.blue.shade200,
      Colors.cyan.shade200,
      Colors.deepOrange.shade200,
      Colors.deepPurple.shade200,
      Colors.green.shade200,
      Colors.indigo.shade200,
      Colors.lightBlue.shade200,
      Colors.lightGreen.shade200,
      Colors.lime.shade200,
      Colors.orange.shade200,
      Colors.pink.shade200,
      Colors.red.shade200,
      Colors.teal.shade200,
      Colors.yellow.shade200,
    ];
    return colors[index % colors.length];
  }

  
  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}

class TransactionData {
  final String title;
  final double amount;
  final DateTime date;

  TransactionData(
      {required this.title, required this.amount, required this.date});

  factory TransactionData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception("Document data is null or does not exist.");
    }
    String title = data['title'] is String ? data['title'] : 'Unknown Title';
    double amount =
        data['amount'] is num ? (data['amount'] as num).toDouble() : 0.0;
    DateTime date = data['date'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.now();
    return TransactionData(
      title: title,
      amount: amount,
      date: date,
    );
  }
}
