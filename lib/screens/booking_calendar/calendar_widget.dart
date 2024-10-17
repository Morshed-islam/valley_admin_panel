import 'package:flutter/material.dart';

class BookingCalendar extends StatefulWidget {
  final List<DateTimeRange> bookedRanges;

  BookingCalendar({required this.bookedRanges});

  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTimeRange? selectedRange;

  bool _isDateDisabled(DateTime date) {
    for (DateTimeRange range in widget.bookedRanges) {
      if (date.isAfter(range.start.subtract(Duration(days: 1))) &&
          date.isBefore(range.end.add(Duration(days: 1)))) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      selectableDayPredicate: (date) => !_isDateDisabled(date),
      onDateChanged: (date) {
        // Handle date selection
      },
    );
  }
}
