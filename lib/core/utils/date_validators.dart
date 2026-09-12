import 'package:equatable/equatable.dart';
import 'package:rain_tech_test/features/booking/domain/booking_repository.dart';

class DateValidationResult extends Equatable {
  final bool isValid;
  final String? errorMessage;

  const DateValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  static const DateValidationResult valid = DateValidationResult(isValid: true);

  static DateValidationResult invalid(String message) =>
      DateValidationResult(isValid: false, errorMessage: message);

  @override
  List<Object?> get props => [isValid, errorMessage];
}

class BookingCalculation extends Equatable {
  final int nights;
  final double roomTotal;
  final double taxAmount;
  final double grandTotal;

  const BookingCalculation({
    required this.nights,
    required this.roomTotal,
    required this.taxAmount,
    required this.grandTotal,
  });

  static const BookingCalculation zero = BookingCalculation(
    nights: 0,
    roomTotal: 0.0,
    taxAmount: 0.0,
    grandTotal: 0.0,
  );

  @override
  List<Object?> get props => [nights, roomTotal, taxAmount, grandTotal];
}

class DateValidators {
  /// Strips time components to compare calendar dates purely.
  static DateTime normalizeDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  /// Calculates the number of nights between check-in and check-out dates.
  /// Returns 0 if either date is null or check-out is not strictly after check-in.
  static int calculateNights(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null || checkOut == null) return 0;

    final normalizedCheckIn = normalizeDate(checkIn);
    final normalizedCheckOut = normalizeDate(checkOut);

    if (!normalizedCheckOut.isAfter(normalizedCheckIn)) {
      return 0;
    }

    return normalizedCheckOut.difference(normalizedCheckIn).inDays;
  }

  /// Calculates room total, tax amount (default 12% GST), and grand total.
  static BookingCalculation calculateTotal(
    double pricePerNight,
    int nights, {
    double taxRate = 0.12,
  }) {
    if (nights <= 0 || pricePerNight <= 0) {
      return BookingCalculation.zero;
    }

    final roomTotal = pricePerNight * nights;
    final taxAmount = double.parse((roomTotal * taxRate).toStringAsFixed(2));
    final grandTotal = double.parse((roomTotal + taxAmount).toStringAsFixed(2));

    return BookingCalculation(
      nights: nights,
      roomTotal: roomTotal,
      taxAmount: taxAmount,
      grandTotal: grandTotal,
    );
  }

  /// Validates check-in and check-out dates.
  /// [referenceNow] can be injected for deterministic unit testing.
  static DateValidationResult validateDates(
    DateTime? checkIn,
    DateTime? checkOut, {
    DateTime? referenceNow,
  }) {
    if (checkIn == null && checkOut == null) {
      return DateValidationResult.invalid('Please select check-in and check-out dates.');
    }

    if (checkIn == null) {
      return DateValidationResult.invalid('Please select a check-in date.');
    }

    if (checkOut == null) {
      return DateValidationResult.invalid('Please select a check-out date.');
    }

    final today = normalizeDate(referenceNow ?? DateTime.now());
    final normalizedCheckIn = normalizeDate(checkIn);
    final normalizedCheckOut = normalizeDate(checkOut);

    if (normalizedCheckIn.isBefore(today)) {
      return DateValidationResult.invalid(
        'Check-in date cannot be in the past.',
      );
    }

    if (normalizedCheckOut.isAtSameMomentAs(normalizedCheckIn)) {
      return DateValidationResult.invalid(
        'Check-out date must be at least 1 night after check-in.',
      );
    }

    if (normalizedCheckOut.isBefore(normalizedCheckIn)) {
      return DateValidationResult.invalid(
        'Check-out date cannot be earlier than check-in date.',
      );
    }

    final nights = calculateNights(checkIn, checkOut);
    if (nights > 60) {
      return DateValidationResult.invalid(
        'Bookings cannot exceed a maximum duration of 60 nights.',
      );
    }

    return DateValidationResult.valid;
  }

  /// Checks if the requested date range overlaps with any existing booking for the room.
  /// Standard date interval intersection: [checkIn, checkOut) intersects [start, end)
  /// if checkIn < end && checkOut > start.
  static bool hasBookingConflict({
    required String roomId,
    required DateTime checkIn,
    required DateTime checkOut,
    required List<BookingRecord> existingBookings,
  }) {
    final start = normalizeDate(checkIn);
    final end = normalizeDate(checkOut);

    if (!end.isAfter(start)) return false;

    for (final booking in existingBookings) {
      if (booking.roomId != roomId) continue;

      final existingStart = normalizeDate(booking.checkInDate);
      final existingEnd = normalizeDate(booking.checkOutDate);

      // Overlap condition: start < existingEnd AND end > existingStart
      if (start.isBefore(existingEnd) && end.isAfter(existingStart)) {
        return true;
      }
    }

    return false;
  }
}
