import 'package:doctor_appointment_front_miros/pages/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart'; // Importar Google Fonts

import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:doctor_appointment_front_miros/pages/homepage.dart';
import 'package:doctor_appointment_front_miros/pages/lostpasswordpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(
        alignment: Alignment.center,
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/img/bg_01.jpg',
            width: double.maxFinite, //Maximo de su contenedor padre
            fit: BoxFit.fitWidth, //Maximo de su contenedor padre
          ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//alinear verticalmente centro

            children: [
              Image.asset(
                'assets/img/Onigiri_3.png',
                width: 250, 
                height: 250,
              ), 


              Text(
                textAlign: TextAlign.left,
                'Onigiri-san',
              style: GoogleFonts.lato(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 9),
            Text(
                textAlign: TextAlign.left,
                'Curamos enfermedades con gatos',
              style: GoogleFonts.lato(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),

              const SizedBox(height: 32),

              // Email Text Field
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
              // Password Text Field
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingresa tu contraseña";
                  }
                  if (value.length < 6) {
                    return "La contraseña debe tener al menos 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Login Button
          
              RoundButton(title: "Iniciar sesión", 
              onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Bienvenido ${userCredential.user!.email}")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const home_alternative()),
                      );
                    } on FirebaseAuthException catch (e) {
                      String message = "";
                      if (e.code == 'user-not-found') {
                        message = "Usuario no encontrado";
                      } else if (e.code == 'wrong-password') {
                        message = "Contraseña incorrecta";
                      } else {
                        message = e.message!;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  }
                },
                ),

              const SizedBox(height: 16),

              Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          TextButton(onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const registerpage()),
                          );
                          },

                          //const Spacer(),

                          child: Text(
                            "Registrate",
                            style: TextStyle( 
                            color:Colors.grey.shade600,
                            fontSize:14, 
                            fontWeight: FontWeight.w600,
                            ),
                          ),

                          ),

                          //Conectar el boton para que te envie a login_screen
                          TextButton(onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Lostpasswordpage()),
                          );
                          },
                          child: Text(
                            "Olvidaste tu contraseña?",
                            style: TextStyle( 
                            color:Colors.grey.shade600,
                            fontSize:14, 
                            fontWeight: FontWeight.w600,
                            ),
                          ),
                          ),

                        ],
                      ),
          
              ],
            ),
          ),
        ),
       ],
      )
    );
  }
}