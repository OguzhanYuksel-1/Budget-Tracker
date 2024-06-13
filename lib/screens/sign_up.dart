import 'package:flutter/material.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:budget_tracker/screens/login_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        'remainingAmount': '0', // Değerler string olmalı
        'totalCredit': '0', // Değerler string olmalı
        'totalDebit': '0', // Değerler string olmalı
      };

      await _authService.createUser(data, context);

      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.green,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                const SizedBox(
                  width: 500,
                  child: Text(
                    "Yeni Hesap Oluştur",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _userNameController,
                  style: const TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration(
                    "Kullanıcı İsmi",
                    Icons.person_sharp,
                  ),
                  validator: _validateUsername,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration(
                    "Email",
                    Icons.email_rounded,
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration(
                    'Telefon Numarası',
                    Icons.phone_enabled_rounded,
                  ),
                  validator: _validatePhoneNumber,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration(
                    'Şifre',
                    Icons.lock_rounded,
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoader ? Colors.grey : null,
                    ),
                    onPressed: isLoader ? null : _submitForm,
                    child: isLoader
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                            "Hesap Oluştur",
                            style:
                                TextStyle(fontSize: 19.0, color: Colors.black),
                            
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  child: const Text(
                    "Giriş Yap",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Lütfen Email Adresinizi Giriniz!';
    }
    RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Lütfen Geçerli Bir Email Adresi Giriniz!';
    }
    return null;
  }

  String? _validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Lütfen Telefon Numaranızı Giriniz!';
    }
    if (value.length != 10) {
      return '10 Haneli Telefon Numaranızı Giriniz!';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Lütfen Şifrenizi Giriniz!';
    }
    return null;
  }

  String? _validateUsername(value) {
    if (value!.isEmpty) {
      return 'Lütfen Kullanıcı İsminizi Giriniz!';
    }
    return null;
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[500],
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      suffixIcon: Icon(
        suffixIcon,
        color: Colors.black,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
