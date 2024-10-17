import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'calendar_widget.dart';

class BookingCalendarScreen extends StatelessWidget {
  final String villaId;

  BookingCalendarScreen({required this.villaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking Calendar')),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('bookings')
            .where('villa_id', isEqualTo: villaId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings found'));
          }

          // Extract booked dates
          List<DateTimeRange> bookedRanges = snapshot.data!.docs.map((doc) {
            DateTime start = DateTime.parse(doc['booking_start_date']);
            DateTime end = DateTime.parse(doc['booking_end_date']);
            return DateTimeRange(start: start, end: end);
          }).toList();

          return BookingCalendar(
            bookedRanges: bookedRanges,
          );
        },
      ),
    );
  }
}
