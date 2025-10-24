import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_front_miros/custom_widget/tab_view.dart';

class MainAppNavigator extends StatelessWidget {
  const MainAppNavigator({super.key});
// es que esta cosa no se encima como deberia y tuve que sacarme este nuevo navegador para repararlo
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: Routes_appflow.home,
      onGenerateRoute: Routes_appflow.generateRoute,
    );
  }
}