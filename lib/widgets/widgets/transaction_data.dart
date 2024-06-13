import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TransactionType { credit, debit }

class TransactionData {
  final String title;
  final double amount;
  final double balance;
  final DateTime date;
  final TransactionType type;
  final IconData categoryIcon;

  TransactionData({
    required this.title,
    required this.amount,
    required this.balance,
    required this.date,
    required this.type,
    required this.categoryIcon,
  });

  factory TransactionData.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    IconData icon = Icons.attach_money; 

    
    switch (data['category'] as String?) {
      case 'shopping':
        icon = Icons.shopping_cart;
        break;
      case 'food':
        icon = Icons.fastfood;
        break;
      default:
        icon = Icons.error; 
    }

    return TransactionData(
      title: data['title'] ?? '',
      amount: (data['amount'] as num).toDouble(),
      balance: (data['balance'] as num).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] == 'credit' ? TransactionType.credit : TransactionType.debit,
      categoryIcon: icon,
    );
  }

  IconData? get category => null;
}




