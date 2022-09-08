import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../network/models/booking_time_model.dart';
import '../../network/services/database_service.dart';

part 'booking_time_state.dart';

class BookingTimeCubit extends Cubit<BookingTimeState> {
  BookingTimeCubit() : super(BookingTimeInitial());

  // Create an object from cubit
  static BookingTimeCubit get(context) => BlocProvider.of(context);

  int selectedTimeIndex = 0;
  void bookingTime(int index) {
    selectedTimeIndex = index;

    emit(SelectedBookingTimeState());
  }

  final DatabaseService _databaseService =
      GetIt.instance.get<DatabaseService>();
  late BookingTimeModel bookingModel;
  void addBookingTime(
    String uID,
    String bookingTime,
    DateTime selectedDate,
  ) async {
    Map<String, dynamic> bookingTimeData = {
      'uid': uID,
      'date': selectedDate,
      'booking_time': bookingTime,
    };
    log(bookingTimeData.toString());
    bookingModel = BookingTimeModel.fromJson(bookingTimeData);

    try {
      await _databaseService.addBookingTimeToFirestore(bookingTimeData);
    } catch (e) {
      log(e.toString());
    }
  }
}
