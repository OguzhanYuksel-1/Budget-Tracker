import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Herocard extends StatelessWidget {
  const Herocard({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Bir şeyler ters gitti');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("Belge mevcut değil");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Yükleniyor");
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;

        final remainingAmount = _parseToInt(data['remainingAmount']);
        final totalCredit = _parseToInt(data['totalCredit']);
        final totalDebit = _parseToInt(data['totalDebit']);

        return Cards(
          remainingAmount: remainingAmount,
          totalCredit: totalCredit,
          totalDebit: totalDebit,
        );
      },
    );
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
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.remainingAmount,
    required this.totalCredit,
    required this.totalDebit,
  });

  final int remainingAmount;
  final int totalCredit;
  final int totalDebit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.blue,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Toplam Bakiye",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$remainingAmount ₺",
              style: const TextStyle(
                fontSize: 45.0,
                color: Colors.white,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Cardone(
                      color: Colors.green,
                      heading: 'Kredi',
                      amount: '$totalCredit',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Cardone(
                      color: Colors.red,
                      heading: 'Borç',
                      amount: '$totalDebit',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cardone extends StatelessWidget {
  const Cardone({
    super.key,
    required this.color,
    required this.heading,
    required this.amount,
  });

  final Color color;
  final String heading;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(color: color, fontSize: 14),
                ),
                Text(
                  "$amount ₺",
                  style: TextStyle(
                    color: color,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                heading == "Kredi"
                    ? Icons.arrow_circle_up_outlined
                    : Icons.arrow_circle_down_outlined,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

