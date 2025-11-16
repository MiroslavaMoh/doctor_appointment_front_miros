import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_front_miros/custom_widget/tab_button.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainTabViewScreen extends StatefulWidget {
  const MainTabViewScreen({super.key});

  @override
  State<MainTabViewScreen> createState() => _MainTabViewScreenState();
}

// Ya no necesitas 'with SingleTickerProviderStateMixin' si no usas TabController
class _MainTabViewScreenState extends State<MainTabViewScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;

  String? userRole; // doctor / Paciente
  bool loadingRole = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  /// Carga el rol del usuario desde Firestore
  Future<void> _loadUserRole() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    
    try {
      final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
      if (doc.exists && doc.data() != null && doc.data()!.containsKey('roles')) {
        setState(() {
          userRole = doc['roles']; // doctor / Paciente
          loadingRole = false;
        });
      } else {
        setState(() {
          userRole = "Paciente"; // valor por defecto
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

  List<String> get routeNames {
    return [
      userRole == "Doctor"            // Index 0 (Condicional)
          ? Routes_appflow.homeDoctor
          : Routes_appflow.home,
      Routes_appflow.messages,        // Index 1
      // --- Lógica de rol ---
      userRole == "Doctor"            // Index 2 (Condicional)
          ? Routes_appflow.appointmentDoctor
          : Routes_appflow.appointment,
      Routes_appflow.ajustes,         // Index 3
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeNames[index], // Getter de nueva lista
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loadingRole) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: 
        userRole == "Doctor"            // Index 0 (Condicional)
          ? Routes_appflow.homeDoctor
          : Routes_appflow.home,
        // Asegúrate que tu onGenerateRoute pase los settings
        onGenerateRoute: (settings) => Routes_appflow.generateRoute(settings),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -4))]
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // --- ¡ARREGLO #2: Simplifica TODOS los botones! ---
              TabButton(
                icon: "assets/img/home.png",
                title: "Inicio",
                isSelect: selectedTab == 0,
                onPressed: () => _onTabSelected(0),
              ),
              TabButton(
                icon: "assets/img/message.png",
                title: "Mensajes",
                isSelect: selectedTab == 1,
                onPressed: () => _onTabSelected(1),
              ),
              // Este botón ahora es simple.
              TabButton(
                icon: "assets/img/cita.png",
                title: "Citas",
                isSelect: selectedTab == 2, // <-- Simple
                onPressed: () => _onTabSelected(2), // <-- Simple
              ),
              TabButton(
                icon: "assets/img/ajuste.png",
                title: "Ajustes",
                isSelect: selectedTab == 3,
                onPressed: () => _onTabSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}