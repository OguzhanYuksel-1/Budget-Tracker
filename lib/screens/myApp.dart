import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker/utils/icons_list.dart';


class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Row(
            children: const [
              Text(
                "Son İşlemler",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 550, 
            child: RecentTransactionList(),
          ),
        ],
      ),
    );
  }
}

class RecentTransactionList extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("transactions")
          .orderBy('timestamp',
              descending: true) 
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Bir şeyler ters gitti');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("İşlem Bulunamadı"));
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
   
    Color amountColor = data['type'] == 'amount' ? Colors.red : Colors.green;

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
              borderRadius: BorderRadius.circular(30),
              color: amountColor.withOpacity(0.0), 
            ),
            child: Center(
              child: FaIcon(appIcons.getExpenseCategoryIcons(data['category']),
                  color: Colors.black87),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                  child: Text(
                data['title'] ?? "Unknown Title",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
              Text(
                "₺ ${data['amount']}",
                style: TextStyle(color: Colors.black87), 
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['category'] ?? "Unknown Category",
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              Row(
                children: [
                  Text(
                    "Güncel Bakiye :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "₺ ${data['remainingAmount']}",
                    style: TextStyle(color: Colors.black54, fontSize: 19),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




