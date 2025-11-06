// NUEVO: Import para detectar la plataforma (iOS/Android)
import 'dart:io';
// NUEVO: Import para los widgets de Cupertino (iOS)
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CupertinoTest extends StatefulWidget {
  const CupertinoTest({super.key});

  @override
  State<CupertinoTest> createState() => _CupertinoTestState();
}

class _CupertinoTestState extends State<CupertinoTest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controladores de formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController enfermedadesController = TextEditingController();

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
    }
  }

  // NUEVO: Helper para mostrar diálogos adaptativos (Cupertino o Material)
  void _showAdaptiveDialog(String title, String content) {
    // Detecta la plataforma
    final bool isIOS = Platform.isIOS;

    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(content)),
      );
    }
  }

  /// 🔹 Guarda o actualiza los datos del usuario
  Future<void> _saveUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final String nombre = nombreController.text.trim();
    final String telefono = telefonoController.text.trim();
    final String enfermedades = enfermedadesController.text.trim();

    if (nombre.isEmpty || telefono.isEmpty || enfermedades.isEmpty) {
      // MODIFICADO: Usa el diálogo adaptativo
      _showAdaptiveDialog(
          'Campos incompletos', 'Por favor completa todos los campos');
      return;
    }

    setState(() => _loading = true);

    try {
      await _firestore.collection('usuarios').doc(user.uid).set({
        'nombre': nombre,
        'telefono': telefono,
        'enfermedades': enfermedades,
        'email': user.email,
        'uid': user.uid,
        'actualizadoEn': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // MODIFICADO: Usa el diálogo adaptativo
      _showAdaptiveDialog('Éxito', 'Información guardada exitosamente');
    } catch (e) {
      // MODIFICADO: Usa el diálogo adaptativo
      _showAdaptiveDialog('Error', 'Error al guardar: $e');
    }

    setState(() => _loading = false);
  }

  /// 🔹 Cierra la sesión y regresa al flujo de autenticación
  Future<void> _logout() async {
    await _auth.signOut();
    if (mounted) {
      // MODIFICADO: Asegura que la ruta de login es correcta
      Navigator.pushReplacementNamed(context, routes_authflow.login);
    }
  }

  // NUEVO: Método helper para construir el formulario (así no duplicamos código)
  Widget _buildForm(BuildContext context, bool isIOS) {
    final user = _auth.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          // MODIFICADO: Estira los widgets en Material, pero no en Cupertino
          crossAxisAlignment:
              isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          children: [
            Text(
              "Correo: ${user?.email ?? 'No disponible'}",
              // MODIFICADO: Estilo de texto unificado
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),

            // --- INICIO DE WIDGETS ADAPTATIVOS ---
            if (isIOS) ...[
              // NUEVO: Formulario estilo Cupertino
              CupertinoTextField(
                controller: nombreController,
                placeholder: 'Nombre completo',
                padding: const EdgeInsets.all(12),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: telefonoController,
                placeholder: 'Teléfono',
                padding: const EdgeInsets.all(12),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: enfermedadesController,
                placeholder: 'Enfermedades o historial médico',
                padding: const EdgeInsets.all(12),
                maxLines: 3,
              ),
            ] else ...[
              // Mantenemos tu formulario Material original
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
              TextField(
                controller: enfermedadesController,
                decoration: const InputDecoration(
                  labelText: 'Enfermedades o historial médico',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
            // --- FIN DE WIDGETS ADAPTATIVOS ---

            const SizedBox(height: 20),

            // --- INICIO DE BOTONES ADAPTATIVOS ---
            if (isIOS) ...[
              // NUEVO: Botones Cupertino
              CupertinoButton.filled(
                onPressed: _saveUserData,
                child: const Text("Guardar información"),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Volver al menú principal"),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                color: CupertinoColors.destructiveRed,
                onPressed: _logout,
                child: const Text("Cerrar sesión"),
              ),
            ] else ...[
              // Mantenemos tu botón Material original
              RoundButton(title: "Guardar información", onPressed: _saveUserData),
              const SizedBox(height: 10),
              
              // NUEVO: Botones Material equivalentes a los de Cupertino
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Volver al menú principal"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _logout,
                  child: const Text("Cerrar sesión"),
                ),
              ),
            ],
            // --- FIN DE BOTONES ADAPTATIVOS ---
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // NUEVO: Detecta la plataforma aquí
    final bool isIOS = Platform.isIOS;

    // NUEVO: Define el indicador de carga adaptativo
    final Widget loadingIndicator = Center(
      child: isIOS
          ? const CupertinoActivityIndicator(radius: 15.0)
          : const CircularProgressIndicator(),
    );

    // NUEVO: Devuelve un Scaffold de Cupertino si es iOS
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Perfil del usuario"),
        ),
        // MODIFICADO: Usa SafeArea para iOS
        child: SafeArea(
          child: _loading ? loadingIndicator : _buildForm(context, isIOS),
        ),
      );
    }

    // MODIFICADO: Tu Scaffold de Material original
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil del usuario")),
      body: _loading ? loadingIndicator : _buildForm(context, isIOS),
    );
  }
}