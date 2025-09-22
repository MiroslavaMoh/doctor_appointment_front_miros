import 'package:doctor_appointment_front_miros/home_alternative.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';              
import 'package:cloud_firestore/cloud_firestore.dart'; // agregar paquete de acceso a clous firestore

// Función principal que inicia la aplicación.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( //Hace conección de firebase 
    options: DefaultFirebaseOptions.currentPlatform, // Usa tu firebase_options.dart
  );
  runApp(const MyApp()); // Corre la aplicación principal una vez que Firebase está listo.
}

// Widget raíz de la aplicación. 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp( //Se usa Materials en el visual
      debugShowCheckedModeBanner: false, //Quitar banner
      //home: HomePage(),// Establece HomePage como la pantalla inicial de la aplicación.
      home: home_alternative(),
    );
  }
}

//Funcionamiento de la página
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  //Función "_guardarCitaDemo" la cual envia los datos a la base de datos
  Future<void> _guardarCitaDemo(BuildContext context) async { 
    await FirebaseFirestore.instance.collection('DocApp').add(
      {
        'paciente': 'Erick Estrella',
        'motivo': 'Revisión general',
        'fecha': '2025-09-30',
      'creadoEn': FieldValue.serverTimestamp(),//Tiempo de creación
    }
    );
    //Mensaje de exito cuando la información ha sido enviada
    if (context.mounted) { //si la información ha sido enviado con exito entonces...
      ScaffoldMessenger.of(context).showSnackBar(//Mensaje visual snackbar (parte inferior de la pantalla)
        const SnackBar(content: Text('Cita guardada ✅')),//texto del mensaje de exito
      );
    }
  }
 
 //Parte visual de la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Firebase')), // Barra y titulo superior de la aplicación.
      //Boton unico en la pantalla
      body: Center(
        child: ElevatedButton(
          onPressed: () => _guardarCitaDemo(context), //Activa la función "_guardarCitaDemo"
          child: const Text('Guardar cita demo'),
        ),
      ),
    );
  }
}
