

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpensesCategories = [
    {"name": "Para Giriş Çıkışı", "icon": FontAwesomeIcons.moneyBillTransfer},
    {"name": "Airbnb", "icon": FontAwesomeIcons.airbnb},
    {"name": "Akaryakıt", "icon": FontAwesomeIcons.gasPump},
    {"name": "Alkol", "icon": FontAwesomeIcons.whiskeyGlass},
    {"name": "Amazon", "icon": FontAwesomeIcons.amazon},
    {"name": "AmazonPay", "icon": FontAwesomeIcons.amazonPay},
    {"name": "AppStore", "icon": FontAwesomeIcons.appStoreIos},
    {"name": "ApplePay", "icon": FontAwesomeIcons.applePay},
    {"name": "Aidat", "icon": FontAwesomeIcons.building},
    {"name": "Bitcoin", "icon": FontAwesomeIcons.bitcoin},
    {"name": "Banka", "icon": FontAwesomeIcons.moneyBillTransfer},
    {"name": "Bagış", "icon": FontAwesomeIcons.mosque},
    {"name": "Discord", "icon": FontAwesomeIcons.discord},
    {"name": "Docker", "icon": FontAwesomeIcons.docker},
    {"name": "Dolar", "icon": FontAwesomeIcons.dollarSign},
    {"name": "Ebay", "icon": FontAwesomeIcons.ebay},
    {"name": "Ethereum", "icon": FontAwesomeIcons.ethereum},
    {"name": "Eğitim", "icon": FontAwesomeIcons.graduationCap},
    {"name": "Elektrik", "icon": FontAwesomeIcons.bolt},
    {"name": "Ev Bakımı", "icon": FontAwesomeIcons.brush},
    {"name": "Evcil Hayvan", "icon": FontAwesomeIcons.paw},
    {"name": "Euro", "icon": FontAwesomeIcons.euroSign},
    {"name": "Facebook", "icon": FontAwesomeIcons.facebook},
    {"name": "Gıda", "icon": FontAwesomeIcons.breadSlice},
    {"name": "Gemi", "icon": FontAwesomeIcons.ship},
    {"name": "Google", "icon": FontAwesomeIcons.google},
    {"name": "Google Drive", "icon": FontAwesomeIcons.googleDrive},
    {"name": "Güzellik", "icon": FontAwesomeIcons.spa},
    {"name": "Hediye", "icon": FontAwesomeIcons.gift},
    {"name": "Instagram", "icon": FontAwesomeIcons.instagram},
    {"name": "İnternet", "icon": FontAwesomeIcons.wifi},
    {"name": "İsviçre Frangi", "icon": FontAwesomeIcons.francSign},
    {"name": "İstanbulkart", "icon": FontAwesomeIcons.subway},
    {"name": "Kira", "icon": FontAwesomeIcons.house},
    {"name": "Line", "icon": FontAwesomeIcons.line},
    {"name": "Nakliye", "icon": FontAwesomeIcons.truck},
    {"name": "Okul", "icon": FontAwesomeIcons.school},
    {"name": "Passaport", "icon": FontAwesomeIcons.passport},
    {"name": "Şarj İstasyonu", "icon": FontAwesomeIcons.carBattery},
    {"name": "Sigara", "icon": FontAwesomeIcons.smoking},
    {"name": "Spotify", "icon": FontAwesomeIcons.spotify},
    {"name": "Spor", "icon": FontAwesomeIcons.dumbbell},
    {"name": "Steam", "icon": FontAwesomeIcons.steam},
    {"name": "Sterlin", "icon": FontAwesomeIcons.sterlingSign},
    {"name": "Su", "icon": FontAwesomeIcons.water},
    {"name": "Trafik Cezası", "icon": FontAwesomeIcons.roadCircleExclamation},
    {"name": "Teleferik", "icon": FontAwesomeIcons.cableCar},
    {"name": "Teknoloji", "icon": FontAwesomeIcons.computer},
    {"name": "TikTok", "icon": FontAwesomeIcons.tiktok},
    {"name": "Twitch", "icon": FontAwesomeIcons.twitch},
    {"name": "Uber", "icon": FontAwesomeIcons.uber},
    {"name": "Ulaşım", "icon": FontAwesomeIcons.bus},
    {"name": "X", "icon": FontAwesomeIcons.x},
  ];
  IconData getExpenseCategoryIcons(String categoryName) {
    final category = homeExpensesCategories.firstWhere(
        (category) => category['name'] == categoryName,
        orElse: () => {"icon": FontAwesomeIcons.cartShopping});
    return category['icon'];
  }
}

