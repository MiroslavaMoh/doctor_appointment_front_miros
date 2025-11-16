import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';

class registerpage extends StatefulWidget {
  const registerpage({super.key});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedRole;

  final List<String> roles = [
    "Paciente",
    "Doctor",
  ];

   Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
        }

        // Guardar en Firestore
        await _firestore.collection('usuarios').doc(user?.uid).set({
          'uid': user?.uid,
          'email': user?.email,
          'nombre': nameController.text.trim(),
          'roles': _selectedRole,   // GUARDAR ROL
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro exitoso. Verifica tu correo.")),
        );

        Navigator.pushReplacementNamed(context, routes_authflow.login);

      } on FirebaseAuthException catch (e) {
        String error = 'Error inesperado';

        if (e.code == 'email-already-in-use') error = 'Este correo ya está en uso.';
        if (e.code == 'invalid-email') error = 'Correo inválido.';
        if (e.code == 'weak-password') error = 'Contraseña muy débil.';

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/Onigiri_1.png',
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
                    'Enviaremos un correo de verificación!',
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Nombre
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu nombre";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

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

                  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Seleccionar rol",
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedRole,
                      items: roles.map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? "Por favor selecciona un rol" : null,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                  // Password
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

                  // Botón de registro (antes decía "Iniciar sesión")
                  RoundButton(
                    title: "Registrarse",
                    onPressed: _registerUser,
                  ),
                  const SizedBox(height: 16),

                  // Links abajo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, routes_authflow.login);

                        },
                        child: Text(
                          "Iniciar sesión",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, routes_authflow.lostpassword);

                        },
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
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
      ),
    );
  }
}
