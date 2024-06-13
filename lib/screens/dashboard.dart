import 'package:budget_tracker/screens/home_screen.dart';
import 'package:budget_tracker/screens/login_screen.dart';
import 'package:budget_tracker/screens/transaction_screen.dart';
import 'package:budget_tracker/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  int currentIndex = 0;
  var pageViewList = [const HomeScreen(),const TransactionScreen()];

  void onDestinationSelected(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  Future<void> logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
     
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );

    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      bottomNavigationBar: NavBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
      ),
      body: pageViewList[currentIndex],
    );
  }
}
