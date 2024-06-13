// import 'package:budget_tracker/utils/icons_list.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class TransactionCard extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final AppIcons appIcons = AppIcons();

//   TransactionCard({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isExpense = data['type'] == 'expense'; // Harcama türünü kontrol et
//     Color textColor = isExpense ? Colors.red : Colors.green; // Harcamalar kırmızı, diğerleri yeşil

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, 10),
//               color: Colors.grey.withOpacity(0.09),
//               blurRadius: 10.0,
//               spreadRadius: 4.0,
//             ),
//           ],
//         ),
//         child: ListTile(
//           minVerticalPadding: 10,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           leading: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: textColor.withOpacity(0.2), // İkon arkaplanını da işlem türüne göre boyayabiliriz
//             ),
//             child: Center(
//               child: FaIcon(appIcons.getExpenseCategoryIcons(data['category']), color: textColor),
//             ),
//           ),
//           title: Row(
//             children: [
//               Expanded(child: Text(data['title'] ?? "Unknown Title", style: TextStyle(color: textColor))),
//               Text(
//                 "₺ ${data['amount']}",
//                 style: TextStyle(color: textColor),
//               ),
//             ],
//           ),
//           subtitle: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data['category'] ?? "Unknown Category",
//                 style: TextStyle(color: Colors.grey, fontSize: 13),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Balance",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 20,
//                     ),
//                   ),
//                   Spacer(),
//                   Text(
//                     "₺ ${data['remainingAmount']}",
//                     style: TextStyle(color: Colors.black, fontSize: 13),
//                   ),
//                 ],
//               ),
//               Text(
//                 "${data['date']} ${data['time']}",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

