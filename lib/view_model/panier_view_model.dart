import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vente_vitment/model/vetement.dart';


class PanierViewModel extends ChangeNotifier {
  List<Vetement> vetements = List.empty(growable: true);
  double prixTotale = 0;



  Future<void> getVetements() async {
    vetements = List.empty(growable: true);
    prixTotale = 0;

    print("from panier waiting");
    await FirebaseFirestore
            .instance
            .collection("carts")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("vetements")
            .get()
            .then((querySnapshot) {
              print("length data: ${querySnapshot.docs.length}");
              for(var docSnapshot in querySnapshot.docs){
                Map<String, dynamic> data = docSnapshot.data();
                //print('${docSnapshot.id} => $data');
                // print("${data.va}");
                vetements.add(
                  Vetement(
                    id: docSnapshot.id,
                    titre: data["titre"].toString(),
                    marque: data["marque"].toString(),
                    categorie: data["categorie"].toString(),
                    taille: data["taille"].toString(),
                    imageBase64: data["imageBase64"].toString(),
                    prix: data["prix"],
                  )
                );
                prixTotale = prixTotale + (data['prix'] as double);
              }
            },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();

    //print("image : ${this.vetements.iterator.current.imageBase64}");
    //notifyListeners();
  }

  void deleteVetementFromCarts(String id){

    FirebaseFirestore
    .instance
    .collection("carts")
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection("vetements")
    .doc(id)
    .delete()
    .then(
      (value) {
        getVetements();
      }
    );
  }
}