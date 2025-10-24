import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
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
          const SnackBar(content: Text('Cita guardada, yay!')),
        );

      }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,//alinear verticalmente centro
          
            children: [
              Text(
                      "Ingresar datos de la cita gatuna",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
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
             /* Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _guardarCita, //Activa la función "_guardarCitaDemo"
                  child: const Text('Guardar cita demo'),
                ),
              ),*/


              RoundButton( //BTN de Common wodgets, recordar importar archivo round_button.dart
                  title:"Guardar cita",
                  onPressed: _guardarCita,
                ),
                const SizedBox(height: 18),
              /*ElevatedButton(
                  onPressed: () async {
                    //await _auth.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sesión cerrada")),
                    );
                  },
                  child: const Text("Cerrar sesión"),
                ),*/

                RoundButton( //BTN de Common wodgets, recordar importar archivo round_button.dart
                  title:"Cerrar sesión",
                  onPressed: () async {
                    //await _auth.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sesión cerrada")),
                    );
                  },
                ),
          
            ],
          ),
        ),
        ),
    );
  }
}