import 'package:doctor_appointment_front_miros/custom_widget/tab_view.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/Profile_page.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/citas_page.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/home_screen.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/messagepage.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/cupertino_test.dart';

//Este es un archivo el cual contienen un sistema centralizado de rutas para la navegacion entre pantallas :D

class Routes_appflow { //
  // Nombres de las rutas 

  //Flujo principal de la app
    static const String home = '/home'; 
    static const String ajustes = '/settings'; //que no puedo poder settings que se repite con el switch jajaja
    static const String messages = '/messages'; 
    static const String appointment = '/appointment'; 
    static const String profile = '/profile'; 
    static const String tabview = '/apphome'; 

  // Generador de rutas
  static Route<dynamic> generateRoute(RouteSettings settings) { 
    switch (settings.name) { 

      //Flujo principal de la app
      case home: 
        return MaterialPageRoute(builder: (_) => const HomeScreen()); 
      case ajustes: 
        return MaterialPageRoute(builder: (_) => const Settingspage()); 
      case messages:
        return MaterialPageRoute(builder: (_) => const Messagepage());
      case appointment: 
        return MaterialPageRoute(builder: (_) => const CitasPage());
      case profile: 
        return MaterialPageRoute(builder: (_) => const CupertinoTest());
      case tabview: 
        return MaterialPageRoute(builder: (_) => const MainTabViewScreen());

      
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