import 'package:flutter/material.dart';
import 'package:vente_vitment/view/screens/login_screen.dart';
import 'package:vente_vitment/view/sections/liste_clothes_section.dart';

class CurrentPageViewModel extends ChangeNotifier {
  Widget currentScreen = const LoginScreen(); //controller: PageController()
  int selectedIndex = 0;

  void setCurrentScreen(Widget screen) {
    currentScreen = screen;
    notifyListeners();
  }

  void setCurrentSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
    notifyListeners();
  }
}