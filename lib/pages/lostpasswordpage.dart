import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:doctor_appointment_front_miros/pages/loginpage.dart';

class Lostpasswordpage extends StatefulWidget {
  const Lostpasswordpage({super.key});

  @override
  State<Lostpasswordpage> createState() => _LostpasswordpageState();
}

class _LostpasswordpageState extends State<Lostpasswordpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Correo de restablecimiento enviado")),
        );

        // Regresar al login después de unos segundos
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      } on FirebaseAuthException catch (e) {
        String message = "Error al enviar correo";

        if (e.code == 'user-not-found') {
          message = "No se encontró una cuenta con este correo";
        } else if (e.code == 'invalid-email') {
          message = "Correo no válido";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/img/bg_01.jpg',
            width: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/Onigiri_2.png',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Onigiri-san',
                    style: GoogleFonts.lato(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    'Te enviaremos un correo para restablecer tu contraseña',
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Email
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Correo electrónico",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu correo";
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return "Correo no válido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Botón de enviar
                  RoundButton(
                    title: "Enviar correo",
                    onPressed: _resetPassword,
                  ),
                  const SizedBox(height: 16),

                  // Botón para volver al login
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: Text(
                      "Inicio de sesión",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
