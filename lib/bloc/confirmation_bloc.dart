import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_front_miros/bloc/confirmation_event.dart';
import 'package:doctor_appointment_front_miros/bloc/confirmation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState>{
  ConfirmationBloc(): super(ConfirmationInitial()){
    on <SendConfirmationEvent>((event, emit)async{
      emit(ConfirmationSending());

      await FirebaseFirestore.instance.collection('confirmations').add({
        'userId':event.userId,
        'appointmentId':event.appointmentId,
        'timestamp':FieldValue.serverTimestamp(),
      });
      emit(ConfirmationSent());
    });
  }
}