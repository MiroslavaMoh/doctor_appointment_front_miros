import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Nombre: Adrián Aguilar",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Volver al Menú Principal"),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacementNamed(context, routes_authflow.login);
              },
              child: const Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}