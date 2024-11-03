import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vente_vitment/view/components/button_login.dart';
import 'package:vente_vitment/view/screens/home_page_screen.dart';
import 'package:vente_vitment/view/components/button_profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:vente_vitment/view_model/panier_view_model.dart';
import 'package:vente_vitment/view_model/user_profil_view_model.dart';
import 'package:vente_vitment/view_model/vetement_view_model.dart';

class LoginScreen extends StatefulWidget {
  //required this.controller
  const LoginScreen({
    super.key,
  });
  //final PageController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    CurrentPageViewModel currentPage =
        Provider.of<CurrentPageViewModel>(context);
    VetementViewModel vetementViwModel =
        Provider.of<VetementViewModel>(context);
    PanierViewModel panierViwModel = Provider.of<PanierViewModel>(context);
    UserProfilViewModel userProfilViewModel =
        Provider.of<UserProfilViewModel>(context);

    this._emailController.text = "user1@email.com";
    this._passController.text = "password1";
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
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/imageLogin.png",
                    height: 300,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFFfC9B92),
                            fontSize: 27,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        controller: _emailController,
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
                        height: 30,
                      ),
                      TextField(
                        obscureText: !_showPassword,
                        controller: _passController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () => _showPassword = !_showPassword,
                              );
                            },
                            icon: const Icon(Icons.remove_red_eye),
                            color: _showPassword
                                ? const Color(0xFFfC9B92)
                                : Colors.grey,
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Color(0xFFfC9B92),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFFfC9B92),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFFfC9B92),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 329,
                          height: 56,
                          child: ButtonLogin(
                            buttonColor: const Color(0xFFfC9B92),
                            buttonName: const Text("Se connecter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passController.text);
                                //print("credential yassine: $credential");
                                await vetementViwModel.getVetements();
                                await panierViwModel.getVetements();
                                await userProfilViewModel.getUser();
                                currentPage
                                    .setCurrentScreen(const HomePageScreen());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "invalid-credential") {
                                  Fluttertoast.showToast(msg: "user or password incorrect");
                                } else {
                                   Fluttertoast.showToast(msg: "other exceptions ${e.code}");
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
