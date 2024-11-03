import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vente_vitment/main.dart';
import 'package:provider/provider.dart';
import 'package:vente_vitment/model/vetement.dart';
import 'package:vente_vitment/view/sections/liste_clothes_section.dart';
import 'package:vente_vitment/view/sections/panier_section.dart';
import 'package:vente_vitment/view/sections/user_profil_section.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/panier_view_model.dart';
import 'package:vente_vitment/view_model/vetement_view_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  Widget build(BuildContext context) {
    CurrentPageViewModel currentPageViewModel =
        Provider.of<CurrentPageViewModel>(context);

    Widget subPage;

    switch (currentPageViewModel.selectedIndex) {
      case 0:
        subPage = const ListeClothesSection();
        break;
      case 1:
        subPage = const PanierSection();
        break;
      case 2:
        subPage = const UserProfilSection();
        break;
      default:
        throw UnimplementedError("no widget for ${currentPageViewModel.selectedIndex}");
    }
    // currentPageViewModel.setCurrentPage(const Placeholder());

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "CHETVTMNT",
              style: TextStyle(
                color: Color(0xFFfC9B92),
                fontSize: 27,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(37, 252, 155, 146),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: subPage,
              ),
              SafeArea(
                child: NavigationBar(
                  backgroundColor: const Color.fromARGB(37, 252, 155, 146),
                  indicatorColor: const Color(0xFFfC9B92),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.attach_money),
                      selectedIcon: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                      label: "Acheter",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.shopping_basket),
                      label: "Panier",
                      selectedIcon: Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_4_rounded),
                      label: "Profile",
                      selectedIcon:
                          Icon(Icons.person_4_rounded, color: Colors.white),
                    ),
                  ],
                  selectedIndex: currentPageViewModel.selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      print("selectedIndex: ${currentPageViewModel.selectedIndex}");
                      currentPageViewModel.selectedIndex = value;
                      //currentPageViewModel.setCurrentPage(const Placeholder());
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
