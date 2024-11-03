import 'package:flutter/material.dart';
import 'package:vente_vitment/view/components/button_style_config/pretty_wave_button.dart';

class ButtonLogin extends StatelessWidget {
  Color buttonColor;
  Widget buttonName;
  VoidCallback onPressed;

  ButtonLogin({super.key,
  required this.buttonColor,
  required this.buttonName,
  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PrettyWaveButton(
      backgroundColor: buttonColor,
      onPressed: onPressed,
      child: buttonName,
    );
  }
}