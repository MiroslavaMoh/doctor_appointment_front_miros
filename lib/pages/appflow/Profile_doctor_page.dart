import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDoctorPage extends StatefulWidget {
  const ProfileDoctorPage({super.key});

  @override
  State<ProfileDoctorPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileDoctorPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controladores de formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController enfermedadesController = TextEditingController();
  final TextEditingController rolesController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 🔹 Carga los datos del usuario desde Firestore
  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('usuarios').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      nombreController.text = data['nombre'] ?? '';
      telefonoController.text = data['telefono'] ?? '';
      enfermedadesController.text = data['enfermedades'] ?? '';
      rolesController.text = data['roles']?.toString() ?? 'Sin rol';

    }
  }

  /// 🔹 Guarda o actualiza los datos del usuario
  Future<void> _saveUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final String nombre = nombreController.text.trim();
    final String telefono = telefonoController.text.trim();
    final String enfermedades = enfermedadesController.text.trim();
    final String roles = rolesController.text.trim();

    if (nombre.isEmpty || telefono.isEmpty || enfermedades.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }


    setState(() => _loading = true);

    try {
      await _firestore.collection('usuarios').doc(user.uid).set({
        'nombre': nombre,
        'telefono': telefono,
        'enfermedades': enfermedades,
        'roles': roles,
        'email': user.email,
        'uid': user.uid,
        'actualizadoEn': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Información guardada exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    }

    setState(() => _loading = false);
  }

  /// 🔹 Cierra la sesión y regresa al flujo de autenticación
  Future<void> _logout() async {
    await _auth.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, routes_authflow.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil del doctor")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Correo: ${user?.email ?? 'No disponible'}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // Formulario
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: telefonoController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),

                   //Solo lectura de rol
                   TextField(
                      controller: rolesController,
                      decoration: const InputDecoration(
                        labelText: 'Rol',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: enfermedadesController,
                      decoration: const InputDecoration(
                        labelText: 'Especialidades',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),

                     RoundButton(title: "Guardar información", 
                      onPressed: _saveUserData),

                  ],
                ),
              ),
            ),
    );
  }
}
