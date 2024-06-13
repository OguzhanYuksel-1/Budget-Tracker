class AppValidator {
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Lütfen Email Adresinizi Giriniz !';
    }
    RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Lütfen Geçerli Bir Email Adresi Giriniz !';
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Lütfen Telefon Numaranızı Giriniz !';
    }
    if (value.length != 10) {
      return '10 Haneli Telefon Numaranızı Giriniz !';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return 'Lütfen Şifrenizi Giriniz !';
    }
    if (value.length != 10) {}
    return null;
  }

  String? validateUsername(value) {
    if (value!.isEmpty) {
      return 'Lütfen Kullancı Adınızı Giriniz ';
    }
    return null;
  }

  String? isEmptyCheck(value) {
    if (value!.isEmpty) {
      return 'Lütfen Detayı Giriniz  ';
    }
    return null;
  }
}
