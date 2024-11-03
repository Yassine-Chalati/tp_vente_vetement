class Vetement {
  String id;
  String titre;
  String marque;
  String categorie;
  String taille;
  String imageBase64;
  double prix;

  Vetement({required this.id, 
    required this.titre, 
    required this.marque, 
    required this.categorie, 
    required this.taille,
    required this.imageBase64,
    required this.prix}
  );
}