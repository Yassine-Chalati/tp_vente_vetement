import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vente_vitment/view/screens/clothe_details_screen.dart';
import 'package:vente_vitment/view/components/vetement_box.dart';
import 'package:vente_vitment/view/components/vetement_panier_box.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/panier_view_model.dart';
import 'package:vente_vitment/view_model/vetement_view_model.dart';
import 'package:provider/provider.dart';

class PanierSection extends StatelessWidget {
  const PanierSection({super.key});

  @override
  Widget build(BuildContext context) {
    PanierViewModel panierViwModel = Provider.of<PanierViewModel>(context);
    CurrentPageViewModel currentPageViewModel = Provider.of<CurrentPageViewModel>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: panierViwModel.vetements.length,
            itemBuilder: (context, index) {
              return VetementPanierBox(
                titre: panierViwModel.vetements[index].titre,
                taille: panierViwModel.vetements[index].taille,
                prix: panierViwModel.vetements[index].prix,
                image: panierViwModel.vetements[index].imageBase64,
                onDelete: () {
                  panierViwModel.deleteVetementFromCarts(panierViwModel.vetements[index].id);
                   Fluttertoast.showToast(msg: "the clothe deleted");
                },
              );
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Text(
                  "Prix: ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${panierViwModel.prixTotale}\$",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}