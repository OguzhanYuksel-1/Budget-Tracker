import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:budget_tracker/widgets/widgets/auth_gate.dart';

class FaceIDAuthScreen extends StatefulWidget {
  const FaceIDAuthScreen({Key? key}) : super(key: key);

  @override
  _FaceIDAuthScreenState createState() => _FaceIDAuthScreenState();
}

class _FaceIDAuthScreenState extends State<FaceIDAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Kimlik doğrulaması için Face ID kullanın',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }

    setState(() {
      _isAuthenticated = authenticated;
    });

    if (_isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthGate()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isAuthenticated
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _authenticate,
                child: Text(''),
              ),
      ),
    );
  }
}
