import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/bookings/booking_model.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchBookings() async {
    _isLoading = true;
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .orderBy('created_at', descending: true)
          .get();

      _bookings = querySnapshot.docs
          .map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      log('Error fetching bookings: $error');
      _isLoading = false;
      notifyListeners();
    }
  }
}
