import 'package:intl/intl.dart';
import 'package:budget_tracker/utils/appvalidator.dart';
import 'package:budget_tracker/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = 'kredi';
  var category = 'Elektrik'; // Varsayılan kategori ayarlandı
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;

  var appValidator = AppValidator();
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      final user = FirebaseAuth.instance.currentUser!;
      int timestamp = DateTime.now().microsecondsSinceEpoch;
      int amount = int.tryParse(amountEditController.text) ?? 0;
      DateTime date = DateTime.now();

      var id = FirebaseFirestore.instance.collection("users").doc().id;
      String monthyear = DateFormat('MMM y').format(date);

      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        int remainingAmount = _parseToInt(userDoc['remainingAmount']);
        int totalCredit = _parseToInt(userDoc['totalCredit']);
        int totalDebit = _parseToInt(userDoc['totalDebit']);

        if (type == 'kredi') {
          remainingAmount += amount;
          totalCredit += amount;
        } else {
          remainingAmount -= amount;
          totalDebit += amount;
        }
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          "remainingAmount": remainingAmount,
          "totalCredit": totalCredit,
          "totalDebit": totalDebit,
          "updatedAt": Timestamp.now(),
        });

        var data = {
          "title": titleEditController.text,
          "amount": amount,
          "type": type,
          "timestamp": timestamp,
          "totalCredit": totalCredit,
          "totalDebit": totalDebit,
          "remainingAmount": remainingAmount,
          "monthyear": monthyear,
          "category": category,
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection("transactions")
            .doc(id)
            .set(data);

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bir hata oluştu: $e')),
        );
      } finally {
        setState(() {
          isLoader = false;
        });
      }
    }
  }

  int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is num) {
      return value.toInt();
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleEditController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: appValidator.isEmptyCheck,
                decoration: const InputDecoration(labelText: 'Başlık'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amountEditController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir miktar girin';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Lütfen geçerli bir sayı girin';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Miktar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryDropDown(
                cattype: category,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      category = value;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: type,
                items: const [
                  DropdownMenuItem(
                    value: 'kredi',
                    child: Text('Kredi'),
                  ),
                  DropdownMenuItem(
                    value: 'borç',
                    child: Text('Borç'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      type = value.toString();
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (!isLoader) {
                  _submitForm();
                }
              },
              child: isLoader
                  ? const Center(child: CircularProgressIndicator())
                  : const Text("İşlem Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}






 
