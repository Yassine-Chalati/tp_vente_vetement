import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vente_vitment/view/components/button_profil.dart';
import 'package:vente_vitment/view/screens/add_clothe_screen.dart';
import 'package:vente_vitment/view/screens/login_screen.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/user_profil_view_model.dart';
import 'package:provider/provider.dart';

class UserProfilSection extends StatefulWidget {
  const UserProfilSection({super.key});

  @override
  State<UserProfilSection> createState() => _UserProfilSectionState();
}

class _UserProfilSectionState extends State<UserProfilSection> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProfilViewModel userProfilViewModel = Provider.of<UserProfilViewModel>(context);
    CurrentPageViewModel currentPageViewModel = Provider.of<CurrentPageViewModel>(context);

    _loginController.text = userProfilViewModel.user.login;
    _passwordController.text = userProfilViewModel.user.password;
    _birthdayController.text = userProfilViewModel.user.birthday;
    _addressController.text = userProfilViewModel.user.address;
    _postalCodeController.text = userProfilViewModel.user.postalCode;
    _cityController.text = userProfilViewModel.user.city;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                controller: _loginController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _birthdayController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Anniversaire',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _addressController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: _postalCodeController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Code Postal',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _cityController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Ville',
                  labelStyle: TextStyle(
                    color: Color(0xFFfC9B92),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFFfC9B92),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 160,
                          height: 56,
                          child: ButtonProfil(
                            buttonColor: Colors.green,
                            buttonName: const SizedBox(
                              width: 200,
                              child: Center(
                                child: Text("Valider",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            onPressed: () async {
                              final user = {
                                "password": _passwordController.text,
                                "birthday": _birthdayController.text,
                                "address": _addressController.text,
                                "postalCode": _postalCodeController.text,
                                "city": _cityController.text,
                              };
                              try {
                                FirebaseAuth.instance.currentUser
                                    ?.updatePassword(_passwordController.text)
                                    .then((value) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .update(user)
                                      .then((onValue) {
                                    userProfilViewModel.getUser();
                                    Fluttertoast.showToast(
                                        msg:
                                            "Information validation successfull!");
                                  });
                                });
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'requires-recent-login') {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Reauthentication required. Please log in again.");
                                  FirebaseAuth.instance.signOut();
                                  currentPageViewModel
                                      .setCurrentScreen(const LoginScreen());
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Exception: ${e.code}");
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "Exception: ${e.hashCode}");
                                rethrow;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 160,
                          height: 56,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ButtonProfil(
                              buttonColor: Colors.red,
                              buttonName: const SizedBox(
                                width: 180,
                                child: Center(
                                  child: Text("Se déconnecter",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                currentPageViewModel
                                    .setCurrentScreen(const LoginScreen());
                                currentPageViewModel
                                    .setCurrentSelectedIndex(0);
                                
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 160,
                    height: 56,
                    child: ButtonProfil(
                      buttonColor: const Color(0xFFfC9B92),
                      buttonName: const SizedBox(
                        width: 200,
                        child: Center(
                          child: Text("Ajouter Vetement",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      onPressed: () async {
                        currentPageViewModel.setCurrentScreen(AddClotheScreen());

                      },
                    ),
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
