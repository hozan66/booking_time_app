import 'dart:developer';

import 'package:booking_app/shared/utils/utils.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/authentication/authentication_cubit.dart';
import '../../blocs/booking_time/booking_time_cubit.dart';
import '../widgets/rounded_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  DateTime _selectedDate = DateTime.now();
  String _timeBooking = timeSlot.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingTimeCubit, BookingTimeState>(
      listener: (context, state) {},
      builder: (context, state) {
        BookingTimeCubit cubit = BookingTimeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            title: const Text(
              'Booking Time App',
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () async {
                  AuthenticationCubit.get(context).logout();
                },
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addTodayDate(),
              _addDateBar(context),
              _buildAvailableAndBookedBar(),
              _buildBookingTimeGridView(cubit),
              _buildBookingTimeButton(context, cubit)
            ],
          ),
        );
      },
    );
  }

  Expanded _buildBookingTimeGridView(BookingTimeCubit cubit) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GridView.builder(
          itemCount: timeSlot.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 5 / 4,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                log('Time picked!');
                cubit.bookingTime(index);

                _timeBooking = timeSlot.elementAt(index);
              },
              child: Card(
                color: cubit.selectedTimeIndex == index
                    ? Colors.orange[500]
                    : Colors.teal,
                child: GridTile(
                  header: cubit.selectedTimeIndex == index
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40.0,
                        )
                      : null,
                  child: Center(
                    child: Text(
                      timeSlot.elementAt(index),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding _buildBookingTimeButton(
      BuildContext context, BookingTimeCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 10.0,
      ),
      child: RoundedButton(
        name: 'Booking Time',
        height: 100.0,
        width: double.infinity,
        onPressed: () {
          log('Booked the time!');

          String uID = AuthenticationCubit.get(context).userModel.uid;
          cubit.addBookingTime(uID, _timeBooking, _selectedDate);

          // BookingTimeModel model=
        },
      ),
    );
  }

  Padding _buildAvailableAndBookedBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.teal,
          ),
          SizedBox(width: 10.0),
          Text(
            'Available',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
          SizedBox(width: 60.0),
          CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 10.0),
          Text(
            'Booked',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Container _addTodayDate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Today',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container _addDateBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: DatePicker(
        daysCount: 20,
        DateTime.now(),
        height: 100.0,
        width: 80.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: Theme.of(context).primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          _selectedDate = date;

          log(_selectedDate.toString());
        },
      ),
    );
  }
}
