import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';  
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home_alternative extends StatefulWidget {
  const home_alternative({super.key});

  @override
  State<home_alternative> createState() => _home_alternativeState();
}

class _home_alternativeState extends State<home_alternative> {
  final TextEditingController _pacienteController =TextEditingController();
  final TextEditingController _motivoController =TextEditingController();

  Future<void> _guardarCita() async {
    final String paciente = _pacienteController.text;
    final String motivo = _motivoController.text;
    //Enviar información
      if (paciente.isNotEmpty && motivo.isNotEmpty){
        await FirebaseFirestore.instance.collection('DocApp').add({
          'paciente':paciente,
          'motivo':motivo,
          'fecha':'2025-09-18',
          'creadoEn': FieldValue.serverTimestamp(),
        });
        //Limpiar
         _pacienteController.clear();
         _motivoController.clear();
        //Mensaje de exito
        if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cita guardada ✅')),
        );

      }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//alinear verticalmente centro

          children: [
            Text(
                textAlign: TextAlign.left,
                'Ingresa los datos de la consulta aquí',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
            const SizedBox(height: 16), 


            //Campos de texto
            TextField(
              controller: _pacienteController, // Vinculamos el controlador.
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Paciente'),
            ),
            const SizedBox(height: 16), 

            TextField(
              controller: _motivoController, // Vinculamos el controlador.
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Motivo'),
            ),
            const SizedBox(height: 24),

            //Boton de enviar
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _guardarCita, //Activa la función "_guardarCitaDemo"
                child: const Text('Guardar cita demo'),
              ),
            ),

            ElevatedButton(
                onPressed: () async {
                  //await _auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sesión cerrada")),
                  );
                },
                child: const Text("Cerrar sesión"),
              ),

          ],
        ),
        ),
    );
  }
}