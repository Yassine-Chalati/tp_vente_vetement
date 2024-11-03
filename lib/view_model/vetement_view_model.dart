import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vente_vitment/model/vetement.dart';


class VetementViewModel extends ChangeNotifier {
  List<Vetement> vetements = List.empty(growable: true);



  Future<void> getVetements() async {
    vetements = List.empty(growable: true);
    var db = FirebaseFirestore.instance;
    await db.collection("clothes").get().then(
      (querySnapshot) {
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
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();

    //print("image : ${this.vetements.iterator.current.imageBase64}");
    //notifyListeners();
  }

  Vetement? getVetement(int id){
    for(Vetement vetement in vetements){
      if(vetement.id == id) {
        return vetement;
      }
    }
    return null;
  }
}