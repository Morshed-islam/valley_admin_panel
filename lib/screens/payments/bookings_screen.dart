import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/booking_provider/booking_provider.dart';

class BookingsPage extends StatefulWidget {
  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<BookingProvider>(context, listen: false).fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, _) {
          final bookings = bookingProvider.bookings;

          if (bookings.isEmpty) {
            return Center(child: Text('No bookings found.'));
          }
          else if (bookingProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(booking.villaName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location: ${booking.villaLocation}'),
                      Text('Day Count: ${booking.dayCount}'),
                      Text('Start: ${booking.bookingStartDate}'),
                      Text('End: ${booking.bookingEndDate}'),
                      Text('Total Amount: \$${booking.totalAmount}'),
                      Text('User Email: ${booking.userEmail}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<BookingProvider>().fetchBookings();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}