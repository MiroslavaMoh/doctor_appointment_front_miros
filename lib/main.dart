import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:doctor_appointment_front_miros/pages/authflow/routes_authflow.dart';
import 'package:doctor_appointment_front_miros/custom_widget/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'pages/authflow/loginpage.dart';

import 'package:google_fonts/google_fonts.dart';//importar google fonts en todo el proyecto

void main() async {
  // Ensure that the Flutter binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login de prueba',
      debugShowCheckedModeBanner: false, // This line disables the debug banner
      //home: MainTabViewScreen(),
      //home: LoginPage(),
       // Rutas iniciales (flujo de login o flujo principal)
      initialRoute: routes_authflow.login, 

      // Aquí se combinan ambos generadores de rutas
      onGenerateRoute: (settings) {
        if (settings.name == routes_authflow.login ||
            settings.name == routes_authflow.register ||
            settings.name == routes_authflow.lostpassword) {
          return routes_authflow.generateRoute(settings);
        } else {
          return Routes_appflow.generateRoute(settings);
        }
      },
    );
  }
}