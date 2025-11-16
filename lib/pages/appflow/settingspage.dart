import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userRole; // doctor / paciente
  bool loadingRole = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  /// Carga el rol del usuario desde Firestore
  Future<void> _loadUserRole() async {
    final uid = _auth.currentUser!.uid;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          userRole = doc['roles']; // doctor / paciente
          loadingRole = false;
        });
      } else {
        setState(() {
          userRole = "Paciente"; // valor por defecto si no hay documento
          loadingRole = false;
        });
      }
    } catch (e) {
      print("Error al cargar el rol del usuario: $e");
      setState(() {
        userRole = "Paciente"; // valor por defecto si hay error
        loadingRole = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loadingRole) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userEmail = _auth.currentUser?.email ?? "Usuario sin nombre";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/img/user.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 15),
                Text(
                  "Tu perfil y configuraciones",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25),

                // Lista de opciones
                ListTile(
                  leading: Icon(Icons.person, color: Colors.grey[600]),
                  title: const Text("Perfil"),
                  onTap: () {
                    if (userRole == "Doctor") {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes_appflow.profileDoctor,
                        arguments: {"role": "doctor"},
                      );
                    } else {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes_appflow.profile,
                        arguments: {"role": "Paciente"},
                      );
                    }
                  },
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.sunny, color: Colors.grey[600]),
                  title: const Text("Color mode"),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.layers, color: Colors.grey[600]),
                  title: const Text("Almacenamiento"),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: Colors.grey[600]),
                  title: const Text("Privacidad"),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.grey[600]),
                  title: const Text("Cerrar sesión"),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                      routes_authflow.login,
                      (route) => false,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Sesión cerrada correctamente"),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
