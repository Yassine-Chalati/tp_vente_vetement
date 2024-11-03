import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vente_vitment/view/components/button_profil.dart';

class VetementPanierBox extends StatelessWidget {
  VoidCallback onDelete;
  final String titre;
  final String taille;
  final double prix;
  final String image;


  VetementPanierBox({super.key, 
  required this.titre,
  required this.taille,
  required this.prix,
  required this.image,
  required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: SizedBox(
        height: 150,
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(78, 252, 155, 146),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    base64Decode(image),
                    width: 90,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        heightFactor: 1,
                        child: Text(
                          titre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "taille: $taille",
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Prix: $prix\$",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  padding: const EdgeInsets.all(0.0),
                  minWidth: 0,
                  height: 0,
                  onPressed: onDelete,
                  child: const Icon(
                    Icons.delete,
                    size: 75,
                    color: Colors.red,
                    ),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}