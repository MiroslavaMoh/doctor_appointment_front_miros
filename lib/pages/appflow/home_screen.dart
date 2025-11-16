import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  int selectIndex = 0;
  //Deslizable de categorias
  List catArr = [
    {"icon": "assets/img/all.png", "title": "Todo"},
    {"icon": "assets/img/fav_m.png", "title": "Mio"},
    {"icon": "assets/img/anxious.png", "title": "Ansiedad"},
    {"icon": "assets/img/sleep_btn.png", "title": "Dormir"},
    {"icon": "assets/img/kids.png", "title": "Kids"},
  ];
  //Fichas de gatos
  List dataArr = [
    {
      "image": "assets/img/Onigiri_1.png",
      "title": "Onigiri",
      "subtitle": "Hablador",
    },
    {
      "image": "assets/img/Onigiri_2.png",
      "title": "Milanesa",
      "subtitle": "Dormilón",
    },
    {
      "image": "assets/img/Onigiri_3.png",
      "title": "Chistorra",
      "subtitle": "Juguetón",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // Recarga los datos del usuario desde Firebase
    await _auth.currentUser?.reload();
    setState(() {
      user = _auth.currentUser;
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
    await _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: const Color(0xff8E97FD),
        backgroundColor: Colors.white,
        displacement: 30,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Necesario para el swipe
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
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
                      const SizedBox(height: 8),
                      Text(
                        "Le deseamos un día miautástico ",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes_appflow.appointment);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff8E97FD),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        "assets/img/Onigiri_2.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                    const Text(
                                      "Crea una visita gatuna",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Escoge fecha y hora",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffFFC97E),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      "assets/img/Onigiri_4.png",
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  const Text(
                                    "Consejos gateros",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Cuida a tu gato",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff333242),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "¿En qué podemos ayudarte hoy?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Encuentra consejos y ayuda de expertos",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/img/Onigiri_1.png",
                              width: 70,
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),

                      Text(
                        "Top Especialidades",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var cObj = catArr[index];
                      return InkWell(
                        onTap: () {
                          setState(() => selectIndex = index);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: selectIndex == index
                                    ? Colors.grey[800]
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                cObj["icon"],
                                width: 25,
                                height: 25,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cObj["title"],
                              style: TextStyle(
                                color: selectIndex == index
                                    ? Colors.grey[800]
                                    : Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(width: 20),
                    itemCount: catArr.length,
                  ),
                ),

                // 🐾 Gatos populares
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Gatos populares",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: dataArr.length,
                  itemBuilder: (context, index) {
                    var cObj = dataArr[index];
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 235, 242),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              cObj["image"],
                              height: 120,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  cObj["title"],
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cObj["subtitle"],
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}