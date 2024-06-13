import 'package:budget_tracker/screens/myApp.dart';
import 'package:budget_tracker/widgets/add_transacetion_form.dart';
import 'package:budget_tracker/widgets/widgets/hero_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

  Future<void> logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );

    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: AddTransactionForm(),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Hoşgeldiniz", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: isLogoutLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Herocard(userId: FirebaseAuth.instance.currentUser!.uid),
            MyAppWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}



