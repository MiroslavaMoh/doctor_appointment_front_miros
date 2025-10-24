
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment_front_miros/custom_widget/tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}
class _HomeScreenState extends State<HomeScreen> {
//Para almacenar estado del nombre de usuario

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;



   int selectIndex = 0;
  List catArr = [
    {"icon": "assets/img/all.png", "title": "Todo"},
    {"icon": "assets/img/fav_m.png", "title": "Mio"},
    {"icon": "assets/img/anxious.png", "title": "Ansiedad"},
    {"icon": "assets/img/sleep_btn.png", "title": "Dormir"},
    {"icon": "assets/img/kids.png", "title": "Kids"},
    {"icon": "assets/img/all.png", "title": "Todo"},
    {"icon": "assets/img/fav_m.png", "title": "Mio"},
    {"icon": "assets/img/anxious.png", "title": "Ansiedad"},
    {"icon": "assets/img/sleep_btn.png", "title": "Dormir"},
    {"icon": "assets/img/kids.png", "title": "Kids"},
  ];
  //Inicio-Lista para seccion deslizable horizontal
  List dataArr = [
    {
      "image": "assets/img/Onigiri_1.png",
      "title": "Onigiri",
      "subtitle": "Hablador",
    },
    {
      "image": "assets/img/Onigiri_2.png",
      "title": "Milanesa",
      "subtitle": "Dormilon",
    },
    {
      "image": "assets/img/Onigiri_3.png",
      "title": "Chistorra",
      "subtitle": "Jugueton",
    },
    {
      "image": "assets/img/Onigiri_4.png",
      "title": "Fetuchinni",
      "subtitle": "Comelon",
    },
     {
      "image": "assets/img/Onigiri_1.png",
      "title": "Curry",
      "subtitle": "Hiperactivo",
    },
  ];
  //Fin-Lista para seccion deslizable horizontal

  @override
  Widget build(BuildContext context) {
    return Material( //
    color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "¡Buenos días, ${user?.displayName ?? 'Usuario'}!",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Le deseamos un día miautastico",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      //Primera tarjeta - morada
                      children: [
                        Expanded(
                            child: InkWell( //Para hacer tap, se requiere material
                          onTap: () {
                            //
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff8E97FD),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/img/Onigiri_2.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Crea una visita",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Escoge fecha y hora",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),

                        //Espaciado entre tarjetas
                        const SizedBox(
                          width: 20,
                        ),

                        //Segunda tarjeta - amarilla
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            //
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFFC97E),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/img/Onigiri_4.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Consejos gateros",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Cuida a tu gato",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),


                    const SizedBox(height: 20,),

                    //Fila oscura de pensamiento diario
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0xff333242),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "¿En que podemos ayudarte hoy?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Encuentra consejos y ayuda de expertos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    "assets/img/Onigiri_1.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //Fin- Fila oscura de pensamiento diario
                    const SizedBox(
                      height: 35,
                    ),

                    //Inicio-Sección deslizable con fichas a partir de la lista superior
                    Text(
                      "Top Especialidades",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
             
              //Inicio-Sección deslizable con fichas de especialidades

              SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var cObj = catArr[index];
                    return InkWell(
                      onTap: () {
                        selectIndex = index;
                         setState(() {});
                      },
                      child: Column(children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: selectIndex == index
                                  ? Colors.grey[800] //Color de fondo de ficha seleccionada
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: Image.asset(
                           cObj["icon"]  ,
                            width: 25,
                            height: 25,
                            color: Colors.white , //color icon
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          cObj["title"],
                          style: TextStyle(
                            color: selectIndex == index ? Colors.grey[800]
                                : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                  itemCount: catArr.length ),
            ),
            //Fin-Sección deslizable con fichas de especialidades
            const SizedBox(
              height: 20,
            ),
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                        "Gatos populares",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Inicio-Fichas de gatos recomendados
            MasonryGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: dataArr.length,
              itemBuilder: (context, index) {
                var height = 50;
                var cObj = dataArr[index] as Map? ?? {};

                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    //
                  },
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                       color: const Color.fromARGB(255, 236, 235, 242),//color de fondo
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.asset(
                            cObj["image"],
                            height: 120,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            
                                child: Container(
                                  color: Colors.grey[800],
                                  width: double.maxFinite,
                                  //color: Colors.black12,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        cObj["title"],
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        cObj["subtitle"],
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )

            //Fin-Fichas de gatos recomendados
            ],
          ),
        )
     ),
    );
    
  }
}

