import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _Settingspage();
}

class _Settingspage extends State<Settingspage> {
  //Logica de visualizacion de ususario
    User? _user; // Variable para almacenar el usuario autenticado
    User? user = FirebaseAuth.instance.currentUser;
    
    @override
    void initState() {
      super.initState();
      _loadUserData(); // Cargar datos del usuario al iniciar la pantalla
    }

    void _loadUserData() {
      setState(() {
        _user = FirebaseAuth.instance.currentUser;
      });
    }
    //fin - Logica de visualizacion de ususario


  @override
  Widget build(BuildContext context) {
    return Material( // <--- AGREGA ESTA LÍNEA
      child:SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/img/user.png",
                      
                      width: 100,
                      height: 100,
                    ),
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
                      _user?.displayName ?? "Usuario sin nombre",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 25),
// Espacio entre título y la lista

                    // Inicio-Lista estilizada
                    SizedBox(
                      child: ListView(
                        shrinkWrap: true, // Se ajusta automáticamente al contenido
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Icon(Icons.notifications, color: Colors.grey[600]),
                              title: Text("Notificaciones"),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Icon(Icons.sunny, color:Colors.grey[600]),
                              title: Text("Color mode"),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Icon(Icons.layers, color: Colors.grey[600]),
                              title: Text("Almacenamiento"),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Icon(Icons.privacy_tip, color: Colors.grey[600]),
                              title: Text("Privacidad"),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Fin lista estilizada
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
