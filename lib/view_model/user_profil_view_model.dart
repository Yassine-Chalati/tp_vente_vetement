import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vente_vitment/model/user_profil.dart';
import 'package:vente_vitment/view/screens/login_screen.dart';

class UserProfilViewModel extends ChangeNotifier {
  late UserProfil user; //controller: PageController()

  Future<void> getUser() async {
    await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then(
        (DocumentSnapshot docSnapshot) {
          if(docSnapshot.exists) {
            Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
            user = UserProfil(
              login: "${data['login']}", 
              password: "${data['password']}", 
              birthday: "${data['birthday']}", 
              address: "${data['address']}", 
              postalCode: "${data['postalCode']}", 
              city: "${data['city']}"
            );
          }
        }
      );

    notifyListeners();
  }
}