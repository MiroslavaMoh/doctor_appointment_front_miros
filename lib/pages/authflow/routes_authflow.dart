import 'package:doctor_appointment_front_miros/pages/authflow/loginpage.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/lostpasswordpage.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/registerpage.dart';
import 'package:flutter/material.dart';
//Este es un archivo el cual contienen un sistema centralizado de rutas para la navegacion entre pantallas :D

class routes_authflow { //
  // Nombres de las rutas 
  //Flujo de inicio de sesion
    static const String login = '/login'; 
    static const String register = '/register'; 
    static const String lostpassword = '/lostpassword'; 


  // Generador de rutas
  static Route<dynamic> generateRoute(RouteSettings settings) { 
    switch (settings.name) { 
      //Flujo de inicio de sesion
      case login: 
        return MaterialPageRoute(builder: (_) => LoginPage()); 
      case register: 
        return MaterialPageRoute(builder: (_) => registerpage());
      case lostpassword: 
        return MaterialPageRoute(builder: (_) => Lostpasswordpage());

      
      // Mensaje por defecto para rutas no definidas
      default: 
        return MaterialPageRoute( 
          builder: (_) => Scaffold( 
            body: Center( 
              child: Text('No route defined for ${settings.name}'), 
            ), 
          ), 
        ); 
    } 
  }
} 