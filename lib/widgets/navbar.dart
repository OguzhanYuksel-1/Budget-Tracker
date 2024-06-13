import 'package:budget_tracker/coin/coinScreen.dart';
import 'package:budget_tracker/screens/exchangeApi.dart';
import 'package:budget_tracker/screens/graphic.dart';
import 'package:budget_tracker/widgets/widgets/chat_gpt_chat-screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "ChatGPT"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_sharp), label: "Kripto"),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: "Grafik"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined), label: "Borsa"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor:
            Colors.blue, 
        unselectedItemColor:
            Colors.grey, 
        onTap: (index) {
          print("Tapped item index: $index");
          switch (index) {
            case 0:
              onDestinationSelected?.call(index);
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CoinScreen()),
              );
              break;
            case 3:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GraphicScreen()),
              );
              break;
            case 4:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CurrencyScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}





