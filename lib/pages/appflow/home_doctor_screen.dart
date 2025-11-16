import 'package:doctor_appointment_front_miros/pages/appflow/routes_appflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeDoctorScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  String? doctorUid;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await _auth.currentUser?.reload();
    setState(() {
      user = _auth.currentUser;
      doctorUid = user?.uid;
      loading = false;
    });
  }

  Future<Map<String, dynamic>> _obtenerEstadisticas() async {
    if (doctorUid == null) return {};

    final snapshot = await _firestore
        .collection('citas')
        .where('doctorId', isEqualTo: doctorUid)
        .get();

    final citas = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    int totalCitas = citas.length;

    Map<String, int> citasPorMes = {};
    Map<String, int> citasPorPaciente = {};

    for (var cita in citas) {
      final fecha = (cita['fechaHora'] as Timestamp?)?.toDate();
      if (fecha != null) {
        final keyMes = "${fecha.year}-${fecha.month.toString().padLeft(2, '0')}";
        citasPorMes[keyMes] = (citasPorMes[keyMes] ?? 0) + 1;
      }

      final paciente = cita['nombreUsuario'] ?? 'Desconocido';
      citasPorPaciente[paciente] = (citasPorPaciente[paciente] ?? 0) + 1;
    }

    String mesMasCitas = 'N/A';
    int maxCitasMes = 0;
    citasPorMes.forEach((mes, cantidad) {
      if (cantidad > maxCitasMes) {
        maxCitasMes = cantidad;
        mesMasCitas = mes;
      }
    });

    List<String> pacientesMasCitas = [];
    int maxCitasPaciente = 0;
    citasPorPaciente.forEach((paciente, cantidad) {
      if (cantidad > maxCitasPaciente) {
        maxCitasPaciente = cantidad;
        pacientesMasCitas = [paciente];
      } else if (cantidad == maxCitasPaciente) {
        pacientesMasCitas.add(paciente);
      }
    });

    return {
      'totalCitas': totalCitas,
      'mesMasCitas': mesMasCitas,
      'pacientesMasCitas': pacientesMasCitas,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async => await _loadUser(),
        color: const Color(0xff8E97FD),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "¡Buenos días, Doctor!",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Le deseamos un día miautástico",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  const SizedBox(height: 25),

                  // Dashboard Tiles
                  FutureBuilder<Map<String, dynamic>>(
                    future: _obtenerEstadisticas(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.data!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTile(
                            title: "Total de citas",
                            value: data['totalCitas'].toString(),
                            color: const Color.fromARGB(255, 222, 90, 119),
                            icon: Icons.event_available,
                          ),
                      
                          _buildTile(
                            title: "Paciente(s) top",
                            value: (data['pacientesMasCitas'] as List<dynamic>).join(', '),
                            color: const Color.fromARGB(255, 72, 194, 219),
                            icon: Icons.person,
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // Resto de la interfaz (por ejemplo, los tiles de citas y consejos)
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
                                  "Ve tus citas agendadas",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Citas de hoy",
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
                              FutureBuilder<Map<String, dynamic>>(
                                future: _obtenerEstadisticas(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator(color: Colors.white);
                                  }
                                  final data = snapshot.data!;
                                  return Text(
                                    data['mesMasCitas'], // Muestra dinámicamente el mes con más citas
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Mes con más citas",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                            

                        ),
                      ),
                      const SizedBox(height: 35),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
