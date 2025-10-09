import 'package:flutter/material.dart';

class AppointmentDetailPage extends StatefulWidget {
  final String userId;
  final String appointmentId;

  const AppointmentDetailPage({
    super.key,
    required this.userId,
    required this.appointmentId,
  });

  @override
  State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}