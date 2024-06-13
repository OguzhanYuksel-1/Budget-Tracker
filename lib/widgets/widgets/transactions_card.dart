import 'package:budget_tracker/utils/icons_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "Son İşlemler",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Expanded(child: RecentTransactionList()),
        ],
      ),
    );
  }
}

class RecentTransactionList extends StatelessWidget {
  RecentTransactionList({
    Key? key,
  }) : super(key: key);

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("transactions")
          .orderBy('timestamp', descending: true) 
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No transactions found"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return TransactionCard(data: data);
          }).toList(),
        );
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final AppIcons appIcons = AppIcons();

  TransactionCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color amountColor = Colors.black; 
    if (data['type'] == 'debt') {
      amountColor = Colors.red;  
    } else if (data['type'] == 'credit') {
      amountColor = Colors.green;  
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              color: Colors.grey.withOpacity(0.09),
              blurRadius: 10.0,
              spreadRadius: 4.0,
            ),
          ],
        ),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: amountColor.withOpacity(0.0),  
            ),
            child: Center(
              child: FaIcon(appIcons.getExpenseCategoryIcons(data['category']), color: amountColor),
            ),
          ),
          title: Row(
            children: [
              Expanded(child: Text(data['title'] ?? "Unknown Title")),
              Text(
                "₺ ${data['amount']}",
                style: TextStyle(color: amountColor = Colors.black)
                  // Miktarın rengi
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Balance",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "₺ ${data['remainingAmount']}",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              Text(
                "${data['date']} ${data['time']}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}














