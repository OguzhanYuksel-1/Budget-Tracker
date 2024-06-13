import 'package:budget_tracker/screens/sign_up.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoader = false; // Düzeltildi: 'var' yerine 'bool' kullanıldı
  final AuthService _authService = AuthService(); // Düzeltildi: 'var' yerine 'AuthService' kullanıldı

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoader = true;
      });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await _authService.login(data, context); 
    
      setState(() {
        _isLoader = false;
      });
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Lütfen Email Adresinizi Giriniz !';
    }
    RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Lütfen Geçerli Bir Email Adresi Giriniz !';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Lütfen Şifrenizi Giriniz !';
    }
    if (value.length < 5) { // Düzeltildi: Şifre uzunluğu kontrolü eklendi
      return 'Şifreniz en az 5 karakter olmalıdır !';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue, // ana ekran renklerinden
              Colors.green, //ana ekran renklerinden
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
                    "Giriş Yap  ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration(
                    "Email",
                    Icons.email_rounded,
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // Düzeltildi: Şifrenin gizlendiği belirtildi
                  style: TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration(
                    'Şifre',
                    Icons.lock_rounded,
                  ),
                  validator: _validatePassword,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: _isLoader ? null : _submitForm, // Düzeltildi: Loader durumuna göre buton etkinliği
                    child: _isLoader ? CircularProgressIndicator() : Text("Giriş Yap"), // Düzeltildi: Loader için CircularIndicator eklendi
                  ),
                ),
               
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpView(),
                      ),
                    );
                  },
                  child: Text(
                    "Yeni Hesap Oluştur  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
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

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[500], // İsim, e-posta, telefon numarası, şifre kutularının arka plan rengi
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ), // Kutuların dış kenarlık rengi
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ), // Odaklandığında kutunun dış kenarlık rengi
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.black,
      ), // Kutu içindeki metin rengi
      suffixIcon: Icon(
        suffixIcon,
        color: Colors.black,
      ), // Sonek ikonunun rengi
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}



