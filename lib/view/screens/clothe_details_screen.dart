import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vente_vitment/model/vetement.dart';
import 'package:vente_vitment/view/components/button_login.dart';
import 'package:vente_vitment/view/screens/home_page_screen.dart';
import 'package:vente_vitment/view/components/button_profil.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/panier_view_model.dart';
import 'package:vente_vitment/view_model/vetement_view_model.dart';
import 'package:provider/provider.dart';

class ClotheDetailsScreen extends StatelessWidget {
  Vetement vetement;

  ClotheDetailsScreen({super.key, required this.vetement});

  @override
  Widget build(BuildContext context) {
    CurrentPageViewModel currentPage =
        Provider.of<CurrentPageViewModel>(context);
    PanierViewModel panierViwModel = Provider.of<PanierViewModel>(context);

    return Scaffold(
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
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              currentPage.setCurrentScreen(const HomePageScreen());
            },
            backgroundColor: const Color(0xFFfC9B92),
            child: const Icon(Icons.arrow_back_ios_new),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(78, 252, 155, 146),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              vetement.titre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(78, 252, 155, 146),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.memory(
                            base64Decode(vetement.imageBase64),
                            height: 250,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(78, 252, 155, 146),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Categorie: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            vetement.categorie,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Taille: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            vetement.taille,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Marque: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            vetement.marque,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Prix: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${vetement.prix}\$",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: ButtonLogin(
                        buttonColor: const Color(0xFFfC9B92),
                        buttonName: const Text(
                          "Ajouter au panier",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          final vtm = {
                            "titre": vetement.titre,
                            "marque": vetement.marque,
                            "categorie": vetement.categorie,
                            "taille": vetement.taille,
                            "imageBase64": vetement.imageBase64,
                            "prix": vetement.prix
                          };

                          await FirebaseFirestore.instance
                              .collection("carts")
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection("vetements")
                              .doc(vetement.id)
                              .set(vtm);
                          await panierViwModel.getVetements();
                           Fluttertoast.showToast(msg: "the clothe added");
                        }),
                  ),
                ],
              ),
            ),
          ),
        )
      );
  }
}
