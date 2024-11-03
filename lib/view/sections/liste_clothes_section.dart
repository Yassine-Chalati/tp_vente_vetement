import 'package:flutter/material.dart';
import 'package:vente_vitment/view/screens/clothe_details_screen.dart';
import 'package:vente_vitment/view/components/vetement_box.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/vetement_view_model.dart';
import 'package:provider/provider.dart';

class ListeClothesSection extends StatelessWidget {
  const ListeClothesSection({super.key});

  @override
  Widget build(BuildContext context) {
    VetementViewModel vetementViwModel = Provider.of<VetementViewModel>(context);
    CurrentPageViewModel currentPageViewModel = Provider.of<CurrentPageViewModel>(context);
    //vetementViwModel.getVetements();

    return ListView.builder(
      itemCount: vetementViwModel.vetements.length,
      itemBuilder: (context, index) {
        return VetementBox(
          titre: vetementViwModel.vetements[index].titre,
          taille: vetementViwModel.vetements[index].taille,
          prix: vetementViwModel.vetements[index].prix,
          image: vetementViwModel.vetements[index].imageBase64,
          onPressed: () {
            currentPageViewModel.setCurrentScreen(ClotheDetailsScreen(vetement: vetementViwModel.vetements[index],));
          },
        );
      }
    );
  }
}