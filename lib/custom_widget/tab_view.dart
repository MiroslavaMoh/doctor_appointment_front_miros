import 'package:doctor_appointment_front_miros/pages/citas_page.dart';
import 'package:doctor_appointment_front_miros/pages/home_screen.dart';
import 'package:doctor_appointment_front_miros/pages/messagepage.dart';
import 'package:doctor_appointment_front_miros/pages/settingspage.dart';

import 'package:doctor_appointment_front_miros/custom_widget/tab_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MainTabViewScreen extends StatefulWidget {
  const MainTabViewScreen({super.key});

  @override
  State<MainTabViewScreen> createState() => _MainTabViewScreenState();
}

class _MainTabViewScreenState extends State<MainTabViewScreen> with SingleTickerProviderStateMixin{

  TabController? controller;
  int selectTab =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller?.addListener((){
      selectTab = controller?.index ?? 0;
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
    
      body: TabBarView(
        controller: controller,
        children: [
        const HomeScreen(),
        const Messagepage(),
        const Settingspage(),
        const CitasPage(),


      ]),

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
              TabButton(icon: "assets/img/kids.png", title: "Inicio", isSelect: selectTab == 0, onPressed: (){
                changeTab(0);}),
              TabButton(icon: "assets/img/fav_m.png", title: "Mensajes", isSelect: selectTab == 1, onPressed: (){
                changeTab(1);}),
              TabButton(icon: "assets/img/sleep_btn.png", title: "Citas", isSelect: selectTab == 2, onPressed: (){
                changeTab(2);}),
              TabButton(icon: "assets/img/anxious.png", title: "Ajustes", isSelect: selectTab == 3, onPressed: (){
                changeTab(3);}),
            ],

        )
        ),
      ),

    );
}
    void changeTab(int index){
      selectTab= index;
      controller?.animateTo(index);
      setState(() {
        
      });
    }
    
}