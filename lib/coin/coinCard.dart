import 'package:flutter/material.dart';
import 'package:budget_tracker/coin/coinModel.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  const CoinCard({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(coin.imageUrl, height: 60, width: 60),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(coin.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  Text(coin.symbol, style: TextStyle(fontSize: 14, color: Colors.grey), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${coin.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${coin.changePercentage.toStringAsFixed(2)}%', style: TextStyle(
                    fontSize: 16,
                    color: coin.changePercentage < 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



