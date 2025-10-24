class Doctor {
  final String id;
  final String nombre;

  Doctor({required this.id, required this.nombre});

  factory Doctor.fromMap(Map<String, dynamic> data, String id) {
    return Doctor(
      id: id,
      nombre: data['nombre'] ?? '',
    );
  }
}
