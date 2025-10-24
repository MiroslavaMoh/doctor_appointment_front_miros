import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_front_miros/custom_widget/tab_button.dart';

class MainTabViewScreen extends StatefulWidget {
  const MainTabViewScreen({super.key});

  @override
  State<MainTabViewScreen> createState() => _MainTabViewScreenState();
}

class _MainTabViewScreenState extends State<MainTabViewScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;

  final List<String> routeNames = [
    Routes_appflow.home,
    Routes_appflow.messages,
    Routes_appflow.appointment,
    Routes_appflow.ajustes,
  ];

  void _onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });

      // Cambia solo el contenido dentro del sub-navegador 
    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeNames[index],
      (route) => false, // Limpia la pila interna del sub-navegador
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: Routes_appflow.home,
        onGenerateRoute: Routes_appflow.generateRoute, // usa tu generador de rutas
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
              TabButton(icon: "assets/img/kids.png", title: "Inicio", isSelect: selectedTab == 0, onPressed: () => _onTabSelected(0)),
              TabButton(icon: "assets/img/fav_m.png", title: "Mensajes", isSelect: selectedTab == 1, onPressed: () => _onTabSelected(1)),
              TabButton(icon: "assets/img/sleep_btn.png", title: "Citas", isSelect: selectedTab == 2, onPressed: () => _onTabSelected(2)),
              TabButton(icon: "assets/img/anxious.png", title: "Ajustes", isSelect: selectedTab == 3, onPressed: () => _onTabSelected(3)),
            ],
          ),
        ),
      ),
    );
  }
}
