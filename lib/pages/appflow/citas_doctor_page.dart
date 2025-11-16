import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/custom_widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class CitasDoctorPage extends StatefulWidget {
  const CitasDoctorPage({super.key});

  @override
  State<CitasDoctorPage> createState() => _CitasDoctorPageState();
}

class _CitasDoctorPageState extends State<CitasDoctorPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? doctorNombre;
  String? doctorUid;
  bool loading = true;

  DateTime? _fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarDoctorDatos();
  }

  Future<void> _cargarDoctorDatos() async {
    final uid = _auth.currentUser!.uid;

    try {
      final doc = await _firestore.collection('usuarios').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          doctorNombre = doc['nombre'];
          doctorUid = doc['uid'];
          developer.log("Datos son: $doctorNombre y $doctorUid");
          loading = false;
        });
      } else {
        setState(() {
          doctorNombre = 'Desconocido';
          doctorUid = '0';
          loading = false;
        });
      }
    } catch (e) {
      developer.log("Error al cargar datos del doctor: $e");
      setState(() {
        doctorNombre = 'Desconocido';
        doctorUid = '0';
        loading = false;
      });
    }
  }

  Future<void> _eliminarCita(String id) async {
    try {
      await _firestore.collection('citas').doc(id).delete();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Cita eliminada")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error al eliminar cita: $e")));
      }
    }
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  Stream<QuerySnapshot> _citasStream() {
    Query query = _firestore.collection('citas')
        .where('doctorId', isEqualTo: doctorUid);

    if (_fechaSeleccionada != null) {
      final start = Timestamp.fromDate(DateTime(
        _fechaSeleccionada!.year,
        _fechaSeleccionada!.month,
        _fechaSeleccionada!.day,
      ));
      final end = Timestamp.fromDate(DateTime(
        _fechaSeleccionada!.year,
        _fechaSeleccionada!.month,
        _fechaSeleccionada!.day,
        23, 59, 59,
      ));
      query = query.where('fechaHora', isGreaterThanOrEqualTo: start)
                   .where('fechaHora', isLessThanOrEqualTo: end);
    }

    return query.orderBy('fechaHora', descending: false).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Citas de $doctorNombre'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filtro por fecha
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _fechaSeleccionada != null
                        ? 'Citas del: ${_fechaSeleccionada!.toLocal().toString().split(' ')[0]}'
                        : 'Todas las citas',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _seleccionarFecha(context),
                  child: const Text('Filtrar por fecha'),
                ),
                if (_fechaSeleccionada != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _fechaSeleccionada = null;
                      });
                    },
                  )
              ],
            ),
          ),

          // Lista de citas
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _citasStream(),
              builder: (context, snapshot) {
                developer.log("El filtro es citas doctorId igual a $doctorUid");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.hasError) {
                  return Center(child: Text('Error al cargar citas: ${snapshot.error}'));
                }

                final citas = snapshot.data!.docs;
                if (citas.isEmpty) {
                  return const Center(child: Text('No hay citas asignadas'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: citas.length,
                  itemBuilder: (context, index) {
                    final cita = citas[index];
                    final data = cita.data() as Map<String, dynamic>? ?? {};
                    final fecha = (data['fechaHora'] as Timestamp?)?.toDate();
                    final motivo = data['motivo'] ?? 'Sin motivo';
                    final pacienteNombre = data['nombreUsuario'] ?? 'Paciente Desconocido';

                    return Card(
                      color: const Color.fromARGB(247, 241, 238, 241),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(pacienteNombre,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('Motivo: $motivo'),
                            if (fecha != null)
                              Text('Fecha: ${fecha.toLocal().toString().substring(0, 16)}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarCita(cita.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
